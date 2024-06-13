import 'package:schuldaten_hub/features/attendance/pages/attendance_page/attendance_list_page.dart';
import 'package:schuldaten_hub/features/main_menu_pages/widgets/landing_bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/main_menu_pages/learn_list_page.dart';
import 'package:schuldaten_hub/features/main_menu_pages/login_page/controller/login_controller.dart';
import 'package:schuldaten_hub/features/main_menu_pages/scan_tools_page.dart';
import 'package:schuldaten_hub/features/main_menu_pages/settings_page.dart';
import 'package:schuldaten_hub/main.dart';

import 'routes.dart';

class AppRoutes {
  static final routes = {
    Routes.start: (context) => const MyApp(),
    Routes.login: (context) => const Login(),
    //Routes.loginScan: (context) => const QRScanCredentials(),
    Routes.home: (context) => BottomNavigation(),
    Routes.attendanceList: (context) => const AttendanceListPage(),
    Routes.learnList: (context) => const LearnListPage(),
    Routes.qrTools: (context) => const ScanToolsPage(),
    //Routes.scanPupils: (context) => const QrScanner(),
    Routes.settings: (context) => const SettingsPage()
  };
}
