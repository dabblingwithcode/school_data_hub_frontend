import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/landing_views/school_lists_view.dart';
import 'package:schuldaten_hub/features/landing_views/learn_list_view.dart';
import 'package:schuldaten_hub/features/landing_views/pupil_lists_menu_view.dart';
import 'package:schuldaten_hub/features/landing_views/scan_tools_view.dart';
import 'package:schuldaten_hub/features/landing_views/settings_view.dart';
import 'package:watch_it/watch_it.dart';

class BottomNavManager {
  ValueListenable<int> get bottomNavState => _bottomNavState;
  ValueListenable<int> get pupilProfileNavState => _pupilProfileNavState;
  ValueListenable<PageController> get pageViewController => _pageViewController;
  final _bottomNavState = ValueNotifier<int>(0);
  final _pageViewController = ValueNotifier<PageController>(PageController());
  final _pupilProfileNavState = ValueNotifier<int>(0);
  BottomNavManager() {
    _bottomNavState.value = 0;
    _pageViewController.value = PageController();
  }
  setBottomNavPage(index) {
    _bottomNavState.value = index;
    if (_pageViewController.value.hasClients) {
      _pageViewController.value.jumpToPage(index);
    }
  }

  setPupilProfileNavPage(index) {
    _pupilProfileNavState.value = index;
  }

  disposePageViewController() {
    _pageViewController.value.dispose();
  }
}

class BottomNavigation extends WatchingWidget {
  BottomNavigation({super.key});

  final List pages = [
    const PupilMenuView(),
    const CheckListsView(),
    const LearnListView(),
    const QrToolsView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final manager = locator<BottomNavManager>();
    final tab = watchValue((BottomNavManager x) => x.bottomNavState);
    final pageViewController =
        watchValue((BottomNavManager x) => x.pageViewController);
    return Scaffold(
      backgroundColor: canvasColor,
      body: PageView(
        controller: pageViewController,
        children: const <Widget>[
          PupilMenuView(),
          CheckListsView(),
          LearnListView(),
          QrToolsView(),
          SettingsView(),
        ],
        onPageChanged: (index) => manager.setBottomNavPage(index),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(canvasColor: backgroundColor),
        child: BottomNavigationBar(
          iconSize: 28,
          onTap: (index) {
            manager.setBottomNavPage(index);
            pageViewController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.bounceOut);
            //BottomNavManager().setBottomNavPage(index);
          },
          showSelectedLabels: true,
          currentIndex: tab,
          selectedItemColor: accentColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              label: 'Kinderlisten',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Schullisten',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: 'Lernen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Einstellungen',
            ),
          ],

          //onTap:
        ),
      ),
    );
  }
}
