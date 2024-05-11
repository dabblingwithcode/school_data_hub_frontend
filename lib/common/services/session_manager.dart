import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';

import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/snackbar_manager.dart';

import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/secure_storage.dart';
import 'package:schuldaten_hub/common/models/session_models/session.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';

class SessionManager {
  ValueListenable<bool> get matrixPolicyManagerRegistrationStatus =>
      _matrixPolicyManagerRegistrationStatus;
  ValueListenable<Session> get credentials => _credentials;
  ValueListenable<bool> get isAuthenticated => _isAuthenticated;
  ValueListenable<bool> get isAdmin => _isAdmin;
  //ValueListenable<int> get credit => _credit;

  ValueListenable<bool> get isRunning => _isRunning;

  final _matrixPolicyManagerRegistrationStatus = ValueNotifier<bool>(false);
  final _credentials = ValueNotifier<Session>(Session());
  final _isAuthenticated = ValueNotifier<bool>(false);
  final _isAdmin = ValueNotifier<bool>(false);
  //final _credit = ValueNotifier<int>(0);

  final _isRunning = ValueNotifier<bool>(false);

  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: locator<EnvManager>().env.value.serverUrl!,
      connectTimeout: Endpoints.connectionTimeout,
      receiveTimeout: Endpoints.receiveTimeout,
      responseType: ResponseType.json,
    ),
  );

  SessionManager();
  Future<SessionManager> init() async {
    await checkStoredCredentials();
    debug.warning('SessionManager initialized!');
    return this;
  }

  authenticate(Session session) {
    _credentials.value = session;
    _isAdmin.value = _credentials.value.isAdmin!;
    _isAuthenticated.value = true;
  }

  changeSessionCredit(int value) async {
    int oldCreditValue = _credentials.value.credit!;
    Session newSession =
        _credentials.value.copyWith(credit: oldCreditValue + value);
    _credentials.value = newSession;
    await saveSession(newSession);
  }

  Future<void> updateSessionData(Session session) async {
    final client = locator.get<ApiManager>().dioClient.value;
    try {
      final response = await client.get(EndpointsUser.getSelfUser);
      if (response.statusCode == 200) {
        final jsonData = response.data;
        Map<String, dynamic> data = jsonDecode(jsonData);
        _credentials.value = _credentials.value.copyWith(
          username: data['name'],
          credit: data['credit'],
          isAdmin: data['admin'],
          role: data['role'],
        );
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');
    }
  }

  Future<void> checkStoredCredentials() async {
    locator<SnackBarManager>().isRunningValue(true);
    if (await secureStorageContains('session') == true) {
      final String? storedSession = await secureStorageRead('session');
      debug.success('Session found!');
      try {
        final Session session = Session.fromJson(
          json.decode(storedSession!) as Map<String, dynamic>,
        );
        if (JwtDecoder.isExpired(session.jwt!)) {
          await secureStorageDelete('session');
          debug.warning(
              'Session was not valid - deleted! | ${StackTrace.current}');
          locator<SnackBarManager>().isRunningValue(false);
          return;
        }
        if (locator<EnvManager>().env.value.serverUrl == null) {
          debug.warning('No environment found! | ${StackTrace.current}');
          locator<SnackBarManager>().isRunningValue(false);
          return;
        }
        debug.info('Stored session is valid! | ${StackTrace.current}');
        authenticate(session);
        debug.warning(
            'SessionManager: isAuthenticated is ${_isAuthenticated.value.toString()}');
        debug.warning('Calling ApiManager instance');
        registerDependentManagers(_credentials.value.jwt!);
        locator<SnackBarManager>().isRunningValue(false);
        return;
      } catch (e) {
        debug.error(
          'Error reading session from secureStorage: $e | ${StackTrace.current}',
        );
        await secureStorageDelete('session');
        locator<SnackBarManager>().isRunningValue(false);
        return;
      }
    } else {
      debug.info('No session found');
      locator<SnackBarManager>().isRunningValue(false);
      return;
    }
  }

  Future<int> refreshToken(String password) async {
    final String username = _credentials.value.username!;
    String auth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final response = await _dio.get(EndpointsUser.login,
        options: Options(headers: <String, String>{'Authorization': auth}));
    if (response.statusCode == 200) {
      final Session session =
          Session.fromJson(response.data).copyWith(username: username);
      authenticate(session);
      await saveSession(_credentials.value);
      locator<ApiManager>().refreshToken(_credentials.value.jwt!);
      return response.statusCode!;
    }
    return response.statusCode!;
  }

  Future<bool> increaseUsersCredit() async {
    final response = await _dio.get(EndpointsUser.increaseCredit);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<void> attemptLogin(String? username, String? password) async {
    String auth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    //_operationReport.value = Report(null, null);
    locator<SnackBarManager>().isRunningValue(true);
    final response = await _dio.get(EndpointsUser.login,
        options: Options(headers: <String, String>{'Authorization': auth}));
    if (response.statusCode == 200) {
      final Session session =
          Session.fromJson(response.data).copyWith(username: username);
      await registerDependentManagers(session.jwt!);
      await saveSession(session);
      authenticate(session);
      //await locator.allReady();
      locator<SnackBarManager>()
          .showSnackBar(SnackBarType.success, 'Login erfolgreich!');
      locator<SnackBarManager>().isRunningValue(false);
      return;
    }
    if (response.statusCode == 401) {
      locator<SnackBarManager>().showSnackBar(
          SnackBarType.warning, 'Login fehlgeschlagen - falsches passwort!');

      return;
    }
    locator<SnackBarManager>().isRunningValue(false);
    return;
  }

  Future<void> saveSession(Session session) async {
    final jsonSession = json.encode(session.toJson());
    await secureStorageWrite('session', jsonSession);
    debug.success('Session stored');
    debug.success(jsonSession);
    return;
  }

  void changeMatrixPolicyManagerRegistrationStatus(bool isRegistered) {
    _matrixPolicyManagerRegistrationStatus.value = isRegistered;
  }

  logout() async {
    locator<SnackBarManager>().isRunningValue(true);
    await secureStorageDelete('session');
    //await secureStorageDelete('pupilBase');
    locator.get<BottomNavManager>().setBottomNavPage(0);
    _isAuthenticated.value = false;
    locator<SnackBarManager>()
        .showSnackBar(SnackBarType.success, 'Zugangsdaten und QR-IDs gelöscht');
    locator<SnackBarManager>().isRunningValue(false);
    await unregisterDependentManagers();
    return;
  }
}