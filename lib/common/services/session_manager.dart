import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/api.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';

import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';

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
  // ValueListenable<int> get credit => _credit;

  final _matrixPolicyManagerRegistrationStatus = ValueNotifier<bool>(false);
  final _credentials = ValueNotifier<Session>(Session());
  final _isAuthenticated = ValueNotifier<bool>(false);
  final _isAdmin = ValueNotifier<bool>(false);
  // final _credit = ValueNotifier<int>(0);

  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: locator<EnvManager>().env.value.serverUrl!,
      connectTimeout: ApiSettings.connectionTimeout,
      receiveTimeout: ApiSettings.receiveTimeout,
      responseType: ResponseType.json,
    ),
  );

  SessionManager();
  Future<SessionManager> init() async {
    await checkStoredCredentials();
    logger.i('Returning SessionManager instance!');
    return this;
  }

  void authenticate(Session session) {
    _credentials.value = session;
    _isAdmin.value = _credentials.value.isAdmin!;
    _isAuthenticated.value = true;
  }

  void changeSessionCredit(int value) async {
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
      logger.f('Dio error: ${errorMessage.toString()} | ${StackTrace.current}');
    }
  }

  Future<void> checkStoredCredentials() async {
    locator<NotificationManager>().isRunningValue(true);
    if (await secureStorageContains('session') == true) {
      final String? storedSession = await secureStorageRead('session');
      logger.i('Session found!');
      try {
        final Session session = Session.fromJson(
          json.decode(storedSession!) as Map<String, dynamic>,
        );
        if (JwtDecoder.isExpired(session.jwt!)) {
          await secureStorageDelete('session');
          logger.w('Session was not valid - deleted!',
              stackTrace: StackTrace.current);
          locator<NotificationManager>().isRunningValue(false);
          return;
        }
        if (locator<EnvManager>().env.value.serverUrl == null) {
          logger.w('No environment found!', stackTrace: StackTrace.current);
          locator<NotificationManager>().isRunningValue(false);
          return;
        }
        logger.i('Stored session is valid!');
        authenticate(session);
        logger.i(
            'SessionManager: isAuthenticated is ${_isAuthenticated.value.toString()}');
        logger.i('Calling ApiManager instance');
        registerDependentManagers(_credentials.value.jwt!);
        locator<NotificationManager>().isRunningValue(false);
        return;
      } catch (e) {
        logger.f(
          'Error reading session from secureStorage: $e',
          stackTrace: StackTrace.current,
        );
        await secureStorageDelete('session');
        locator<NotificationManager>().isRunningValue(false);
        return;
      }
    } else {
      logger.i('No session found');
      locator<NotificationManager>().isRunningValue(false);
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
    locator<NotificationManager>().isRunningValue(true);
    final response = await _dio.get(EndpointsUser.login,
        options: Options(headers: <String, String>{'Authorization': auth}));
    if (response.statusCode == 200) {
      final Session session =
          Session.fromJson(response.data).copyWith(username: username);
      await registerDependentManagers(session.jwt!);
      await saveSession(session);
      authenticate(session);
      //await locator.allReady();
      locator<NotificationManager>()
          .showSnackBar(NotificationType.success, 'Login erfolgreich!');
      locator<NotificationManager>().isRunningValue(false);
      return;
    }
    if (response.statusCode == 401) {
      locator<NotificationManager>().showSnackBar(NotificationType.warning,
          'Login fehlgeschlagen - falsches passwort!');

      return;
    }
    locator<NotificationManager>().isRunningValue(false);
    return;
  }

  Future<void> saveSession(Session session) async {
    final jsonSession = json.encode(session.toJson());
    await secureStorageWrite('session', jsonSession);
    logger.i('Session stored');
    logger.i(jsonSession);
    return;
  }

  void changeMatrixPolicyManagerRegistrationStatus(bool isRegistered) {
    _matrixPolicyManagerRegistrationStatus.value = isRegistered;
  }

  logout() async {
    locator<NotificationManager>().isRunningValue(true);
    await secureStorageDelete('session');
    //await secureStorageDelete('pupilBase');
    locator.get<BottomNavManager>().setBottomNavPage(0);
    _isAuthenticated.value = false;
    locator<NotificationManager>().showSnackBar(
        NotificationType.success, 'Zugangsdaten und QR-IDs gelöscht');
    locator<NotificationManager>().isRunningValue(false);
    await unregisterDependentManagers();
    return;
  }
}
