import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:schuldaten_hub/features/authorizations/views/new_authorization_view/new_authorization_view.dart';

class AuthorizationListBottomNavBar extends StatelessWidget {
  const AuthorizationListBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        padding: const EdgeInsets.all(9),
        shape: null,
        color: backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(30),
              if (locator<SessionManager>().isAdmin.value == true)
                IconButton(
                  tooltip: 'Neue Liste',
                  icon: const Icon(
                    Icons.add,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const NewAuthorizationView(),
                    ));
                  },
                ),
              const Gap(15)
            ],
          ),
        ),
      ),
    );
  }
}
