import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:schuldaten_hub/common/models/session_models/env.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/logger.dart';
import 'package:schuldaten_hub/common/utils/secure_storage.dart';
import 'package:schuldaten_hub/features/main_menu_pages/widgets/landing_bottom_nav_bar.dart';

class EnvManager {
  ValueListenable<Env> get env => _env;
  ValueListenable<Env> get testEnv => _testEnv;
  ValueListenable<bool> get envReady => _envReady;
  ValueListenable<PackageInfo> get packageInfo => _packageInfo;

  final _env = ValueNotifier<Env>(Env());
  final _testEnv = ValueNotifier<Env>(Env());
  final _envReady = ValueNotifier<bool>(false);
  final _packageInfo = ValueNotifier<PackageInfo>(PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  ));

  EnvManager();
  Future<EnvManager> init() async {
    logger.i('EnvManager constructor called!');
    await checkStoredEnv();
    logger.i('returning EnvManager instance!');
    return this;
  }

  Future<void> checkStoredEnv() async {
    bool isStoredEnv = await secureStorageContains('env');
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _packageInfo.value = packageInfo;
    if (isStoredEnv == true) {
      final String? storedSession = await secureStorageRead('env');
      logger.i('env found!');
      try {
        final env = Env.fromJson(
          json.decode(storedSession!) as Map<String, dynamic>,
        );
        _env.value = env;
        _envReady.value = true;

        return;
      } catch (e) {
        logger.f('Error reading env from secureStorage!',
            stackTrace: StackTrace.current);

        await secureStorageDelete('env');

        return;
      }
    } else {
      logger.i('No env found');

      return;
    }
  }

  Future<void> checkStoredTestEnv() async {
    bool isStoredEnv = await secureStorageContains('testEnv');
    if (isStoredEnv == true) {
      final String? storedSession = await secureStorageRead('testEnv');
      logger.i('testEnv found!');

      final env = Env.fromJson(
        json.decode(storedSession!) as Map<String, dynamic>,
      );
      _testEnv.value = env;
    }
  }

  // set the test environment
  void setTestEnv(String scanResult) async {
    final Env env =
        Env.fromJson(json.decode(scanResult) as Map<String, dynamic>);
    _testEnv.value = env;

    final jsonEnv = json.encode(env.toJson());
    await secureStorageWrite('testEnv', jsonEnv);
    _envReady.value = true;
    logger.i('Test Env stored');
    logger.i(jsonEnv);
  }

  // set the environment from a string
  void setEnv(String scanResult) async {
    final Env env =
        Env.fromJson(json.decode(scanResult) as Map<String, dynamic>);
    _env.value = env;

    final jsonEnv = json.encode(env.toJson());
    await secureStorageWrite('env', jsonEnv);

    _envReady.value = true;
    logger.i('Env stored');
    logger.i(jsonEnv);
    return;
  }

  deleteTestEnv() async {
    _testEnv.value = Env();
    await secureStorageDelete('testEnv');
    //await secureStorageDelete('pupilIdentities');
    locator.get<BottomNavManager>().setBottomNavPage(0);
  }

  deleteEnv() async {
    _env.value = Env();
    _envReady.value = false;
    await secureStorageDelete('env');
    //await secureStorageDelete('pupilIdentities');
    locator.get<BottomNavManager>().setBottomNavPage(0);
  }
}
