import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:schuldaten_hub/api/services/connection_manager.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/routes/app_routes.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/landing_views/loading_page.dart';
import 'package:schuldaten_hub/features/landing_views/login_view/controller/login_controller.dart';
import 'package:schuldaten_hub/features/landing_views/no_connection_view.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';
import 'package:window_manager/window_manager.dart';

import 'common/services/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // using package window_manager for windows window size
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1200, 800),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
    ),
  );
  registerBaseManagers();
  await locator.isReady<EnvManager>();
  await locator.isReady<ConnectionManager>();
  await locator.isReady<SessionManager>();
  await locator.isReady<PupilIdentityManager>();

  runApp(const MyApp());
  // This is a hack to avoid calls to firebase from the mobile_scanner package every 15 minutes
  // like described here: https://github.com/juliansteenbakker/mobile_scanner/issues/553
  if (Platform.isAndroid) {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.parent.path;
    final file =
        File('$path/databases/com.google.android.datatransport.events');
    await file.writeAsString('Fake');
  }
}

class MyApp extends WatchingWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool envIsReady = watchValue((EnvManager x) => x.envReady);
    bool isAuthenticated = watchValue((SessionManager x) => x.isAuthenticated);

    AsyncSnapshot<List<ConnectivityResult>?> connectionStatus =
        watchStream((ConnectionManager x) => x.connectivity.value);

    bool isConnected = connectionStatus.hasData
        ? connectionStatus.data!.last != ConnectivityResult.none
            ? true
            : false
        : false;

    return MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('de', 'DE'), // Set the default locale to German
      ],
      debugShowCheckedModeBanner: false,
      title: 'Schuldaten Hub',
      routes: AppRoutes.routes,
      home: !isConnected
          ? const NoConnectionView()
          : envIsReady && isAuthenticated
              ? FutureBuilder(
                  future: locator.allReady(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return BottomNavigation();
                    } else {
                      return const LoadingPage();
                    }
                  },
                )
              : const Login(),
    );
  }
}
