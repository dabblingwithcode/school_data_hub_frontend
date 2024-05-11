import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/dio/dio_client.dart';
import 'package:schuldaten_hub/api/endpoints/matrix_endpoints.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/secure_storage.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_user.dart';
import 'package:schuldaten_hub/features/matrix/models/policy.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_helper_functions.dart';
import 'package:schuldaten_hub/features/matrix/services/pdf_printer/matrix_credentials_printer.dart';

class MatrixCredentials {
  final String url;
  final String matrixToken;
  final String policyToken;

  MatrixCredentials(
      {required this.url,
      required this.matrixToken,
      required this.policyToken});

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'matrixToken': matrixToken,
      'policyToken': policyToken,
    };
  }

  factory MatrixCredentials.fromJson(Map<String, dynamic> json) {
    return MatrixCredentials(
      url: json['url'] as String,
      matrixToken: json['matrixToken'] as String,
      policyToken: json['policyToken'] as String,
    );
  }
}

class MatrixPolicyManager {
  ValueListenable<Policy> get matrixPolicy => _matrixPolicy;
  ValueListenable<bool> get pendingChanges => _pendingChanges;
  ValueListenable<List<MatrixUser>> get matrixUsers => _matrixUsers;
  ValueListenable<List<MatrixRoom>> get matrixRooms => _matrixRooms;
  ValueListenable<String> get matrixUrl => _matrixUrl;
  ValueListenable<String> get matrixToken => _matrixToken;
  ValueListenable<String> get matrixAdmin => _matrixAdmin;
  ValueListenable<String> get policyToken => _policyToken;

  final _matrixAdmin = ValueNotifier<String>('');
  final _matrixPolicy = ValueNotifier<Policy>(Policy());
  final _pendingChanges = ValueNotifier<bool>(false);
  final _matrixToken = ValueNotifier<String>('');
  final _matrixUsers = ValueNotifier<List<MatrixUser>>(<MatrixUser>[]);
  final _matrixRooms = ValueNotifier<List<MatrixRoom>>(<MatrixRoom>[]);
  final _matrixUrl = ValueNotifier<String>('');
  final _policyToken = ValueNotifier<String>('');
  MatrixPolicyManager() {
    debug.warning('MatrixPolicyManager initializing! | ${StackTrace.current}');
  }

  Future<MatrixPolicyManager> init() async {
    if (locator<SessionManager>().isAdmin.value == true) {
      if (await secureStorageContains('matrix')) {
        try {
          String? matrixStoredValues = await secureStorageRead('matrix');
          if (matrixStoredValues == null) {
            throw Exception('Matrix stored values are null');
          }
          final MatrixCredentials credentials =
              MatrixCredentials.fromJson(jsonDecode(matrixStoredValues));
          _matrixUrl.value = credentials.url;
          _matrixToken.value = credentials.matrixToken;
          _policyToken.value = credentials.policyToken;
          await fetchMatrixPolicy();
        } catch (e) {
          debug.error(
              'Error reading matrix credentials from secureStorage: $e | ${StackTrace.current}');
          await secureStorageDelete('matrix');
        }
      }
    }
    return this;
  }

  //-TOOLS
  void pendingChangesHandler(bool value) {
    if (value == _pendingChanges.value) return;
    _pendingChanges.value = value;
  }

  void setMatrixEnvironmentValues(
      {required String url,
      required String policyToken,
      required String matrixToken}) async {
    _matrixUrl.value = url;
    _policyToken.value = policyToken;
    _matrixToken.value = matrixToken;
    secureStorageWrite(
        'matrix',
        jsonEncode(MatrixCredentials(
                url: url, matrixToken: matrixToken, policyToken: policyToken)
            .toJson()));
    await fetchMatrixPolicy();
  }

  //- SETUP MATRIX CLIENT
  DioClient matrixClient(String token) {
    locator<ApiManager>().setCustomDioClientOptions(
        _matrixUrl.value, 'Authorization', 'Bearer $token', false);
    return locator<ApiManager>().dioClient.value;
  }

  //- MATRIX POLICY
  Future fetchMatrixPolicy() async {
    final client = matrixClient(_policyToken.value);

    final response = await client.get(
      '${_matrixUrl.value}_matrix/corporal/policy',
    );
    debug.success('Response: ${response.data}');

    if (response.statusCode == 200) {
      final Policy policy = Policy.fromJson(response.data['policy']);
      List<MatrixRoom> rooms = [];
      locator<ApiManager>().setCustomDioClientOptions(_matrixUrl.value,
          'Authorization', 'Bearer ${_matrixToken.value}', false);

      for (MatrixRoom room in policy.matrixRooms ?? []) {
        MatrixRoom namedRoom = await fetchAdditionalRoomInfos(room);
        rooms.add(namedRoom);
      }
      Policy newPolicy = Policy(
        schemaVersion: policy.schemaVersion,
        identificationStamp: policy.identificationStamp,
        flags: policy.flags,
        hooks: policy.hooks,
        matrixRooms: rooms.toSet().toList(),
        matrixUsers: List<MatrixUser>.from(policy.matrixUsers ?? []),
      );
      _matrixPolicy.value = newPolicy;
      _matrixUsers.value = newPolicy.matrixUsers ?? [];
      _matrixRooms.value = newPolicy.matrixRooms ?? [];

      debug.success('Fetched Matrix policy! | ${StackTrace.current}');
    }
    locator<SessionManager>().changeMatrixPolicyManagerRegistrationStatus(true);
    locator.get<ApiManager>().setDefaultDioClientOptions();
    return;
  }

  //- ROOM REPOSITORY

  Future createNewRoom(String name, String topic, String? aliasName) async {
    final client = matrixClient(_matrixToken.value);
    final data = jsonEncode({
      {
        "creation_content": {"m.federate": false},
        "name": name,
        "preset": "private_chat",
        if (aliasName != null) "room_alias_name": "testraum2",
        "topic": topic
      }
    });

    final Response response =
        await client.post(EndpointsCorporal.createRoom, data: data);
    if (response.statusCode == 200) {
      // extract the value of "room_id" out of the response
      final String roomId = jsonDecode(response.data)['room_id'];
      addManagedRoom(roomId, name);
    }
    locator.get<ApiManager>().setDefaultDioClientOptions();
  }

  addManagedRoom(String id, String name) {
    final MatrixRoom newRoom = MatrixRoom(id: id, name: name);
    final List<MatrixRoom> updatedList = List.from(_matrixRooms.value)
      ..add(newRoom);
    _matrixRooms.value = updatedList;
    final List<MatrixUser> matrixUsers = List.from(_matrixUsers.value);
    final int matrixAdminIndex =
        matrixUsers.indexWhere((element) => element.id == _matrixAdmin.value);
    if (matrixAdminIndex != -1) {
      matrixUsers[matrixAdminIndex] = matrixUsers[matrixAdminIndex].copyWith(
        matrixRooms: [...matrixUsers[matrixAdminIndex].matrixRooms!, newRoom],
      );
    }
    _matrixUsers.value = matrixUsers;
    _pendingChanges.value = true;
  }

  Future setRoomPowerLevels(String roomId, List<RoomAdmin>? adminPowerLevels,
      int eventsDefault, int reactions) async {
    final client = matrixClient('Bearer ${_matrixToken.value}');
    final data = jsonEncode({
      "ban": 50,
      "events": {
        "m.room.name": 50,
        "m.room.power_levels": 100,
        "m.room.history_visibility": 100,
        "m.room.canonical_alias": 50,
        "m.room.avatar": 50,
        "m.room.tombstone": 100,
        "m.room.server_acl": 100,
        "m.room.encryption": 100,
        "m.space.child": 50,
        "m.room.topic": 50,
        "m.room.pinned_events": 50,
        "m.reaction": reactions,
        "m.room.redaction": 0,
        "org.matrix.msc3401.call": 50,
        "org.matrix.msc3401.call.member": 50,
        "im.vector.modular.widgets": 50,
        "io.element.voice_broadcast_info": 50
      },
      "events_default": eventsDefault,
      "invite": 50,
      "kick": 50,
      "notifications": {"room": 20},
      "redact": 50,
      "state_default": 50,
      if (adminPowerLevels != null) "users": adminPowerLevels,
      if (adminPowerLevels == null) "users": {_matrixAdmin.value: 100},
      "users_default": 0
    });

    final response = await client.put(
        '${_matrixUrl.value}${EndpointsCorporal().putRoomPowerLevels(roomId)}',
        data: data);
    debug.success('Response: ${response.data}');
    locator.get<ApiManager>().setDefaultDioClientOptions();
  }

  Future<MatrixRoom> fetchAdditionalRoomInfos(MatrixRoom room) async {
    final client = locator<ApiManager>().dioClient.value;
    String name = room.name ?? '';
    int powerLevelReactions = 0;
    int eventsDefault = 0;
    List<RoomAdmin> roomAdmins = [];

    // First API call
    final responseRoomSPowerLevels = await client.get(
      '${_matrixUrl.value}${EndpointsCorporal().fetchRoomPowerLevels(room.id)}',
    );

    if (responseRoomSPowerLevels.statusCode == 200) {
      powerLevelReactions =
          responseRoomSPowerLevels.data['events']['m.reaction'] ?? 0;
      eventsDefault = responseRoomSPowerLevels.data['events_default'] ?? 0;

      if (responseRoomSPowerLevels.data['users'] is Map<String, dynamic>) {
        final usersMap =
            responseRoomSPowerLevels.data['users'] as Map<String, dynamic>;
        roomAdmins = usersMap.keys
            .map(
                (userId) => RoomAdmin(id: userId, powerLevel: usersMap[userId]))
            .toList();
      }
    }

    // Second API call
    final responseRoomName = await client.get(
      '${_matrixUrl.value}${EndpointsCorporal().fetchRoomName(room.id)}',
    );

    if (responseRoomName.statusCode == 200) {
      name = responseRoomName.data['name'] ?? name;
    }

    MatrixRoom roomWithAdditionalInfos = room.copyWith(
      name: name,
      powerLevelReactions: powerLevelReactions,
      eventsDefault: eventsDefault,
      roomAdmins: roomAdmins,
    );

    return roomWithAdditionalInfos;
  }
  //- USER REPOSITORY

  Future createNewMatrixUser(String userId, String displayName) async {
    final client = matrixClient(_matrixToken.value);
    final password = generatePassword();
    final data = jsonEncode({
      "user_id": userId,
      "password": password,
      "admin": false,
      "displayname": displayName,
      "threepids": [],
      "avatar_url": ""
    });

    final Response response = await client.put(
      EndpointsCorporal().createMatrixUser(userId),
      data: data,
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final MatrixUser newUser = MatrixUser(
        id: userId,
        displayName: displayName,
      );
      final List<MatrixUser> updatedList = List.from(_matrixUsers.value)
        ..add(newUser);
      _matrixUsers.value = updatedList;
      await printMatrixCredentials(_matrixUrl.value, newUser, password);
    }
    locator.get<ApiManager>().setDefaultDioClientOptions();
    _pendingChanges.value = true;
    return;
  }

  Future deleteUser(String userId) async {
    final client = matrixClient(_matrixToken.value);
    final data = jsonEncode({
      "erase": true,
    });
    final Response response = await client
        .delete(EndpointsCorporal().deleteMatrixUser(userId), data: data);
    if (response.statusCode == 200) {
      final List<MatrixUser> updatedList = List.from(_matrixUsers.value)
        ..removeWhere((element) => element.id == userId);
      _matrixUsers.value = updatedList;
    }
    _pendingChanges.value = true;
    locator.get<ApiManager>().setDefaultDioClientOptions();
  }

  Future addMatrixUserToRooms(String matrixUserId, List<String> roomIds) async {
    List<MatrixRoom> rooms = roomsFromRoomIds(roomIds);
    List<MatrixUser> matrixUsers = List.from(_matrixUsers.value);
    int matrixUserIndex =
        matrixUsers.indexWhere((element) => element.id == matrixUserId);
    if (matrixUserIndex != -1) {
      // add rooms to the user, avoid duplicates
      List<MatrixRoom> updatedRooms =
          List<MatrixRoom>.from(matrixUsers[matrixUserIndex].matrixRooms ?? [])
            ..addAll(rooms);
      matrixUsers[matrixUserIndex] = matrixUsers[matrixUserIndex]
          .copyWith(matrixRooms: updatedRooms.toSet().toList());
      _matrixUsers.value = matrixUsers;
      _pendingChanges.value = true;
    }
  }
}
