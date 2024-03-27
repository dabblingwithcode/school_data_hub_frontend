import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/dio/dio_client.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';

import '../../common/services/locator.dart';

final token = locator<SessionManager>().credentials.value.jwt;

class ApiManager {
  ValueListenable<String> get token => _token;
  ValueListenable<DioClient> get dioClient => _dioClient;
  ValueListenable<bool> get isRunning => _isRunning;

  final _token = ValueNotifier<String>('');
  final _dioClient = ValueNotifier<DioClient>(DioClient(Dio(), '', '', null));
  final _isRunning = ValueNotifier<bool>(false);
  ApiManager();
  Future<ApiManager> init(String token) async {
    await setApi(token);
    debug.warning('ApiManager should be ready now');
    return this;
  }

  setApi(String token) {
    _token.value = token;
    final baseUrl = locator<EnvManager>().env.value.serverUrl;
    //static const baseUrl = 'http://10.0.2.2:5000/api'; // android VM
    //static const baseUrl = 'http://127.0.0.1:5000/api'; //windows
    _dioClient.value = DioClient(Dio(), token, baseUrl, false);
  }
}
