import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/logger.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/landing_views/login_view/controller/login_controller.dart';

import 'package:watch_it/watch_it.dart';

class LoginView extends WatchingWidget {
  final LoginController controller;
  const LoginView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    registerHandler(
      select: (NotificationManager x) => x.notification,
      handler: (context, value, cancel) =>
          snackbar(context, value.type, value.message),
    );
    bool isAuthenticated = watchValue((SessionManager x) => x.isAuthenticated);
    bool envReady = watchValue((EnvManager x) => x.envReady);
    final locale = AppLocalizations.of(context)!;
    logger.i('LoginView: isAuthenticated: ${isAuthenticated.toString()}');
    final bool keyboardOn = MediaQuery.of(context).viewInsets.vertical > 0.0;
    //FocusScopeNode currentFocus = FocusScope.of(context);

    return (envReady && isAuthenticated)
        ? BottomNavigation()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              color: const Color.fromRGBO(74, 76, 161, 1),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: keyboardOn
                              ? const EdgeInsets.only(top: 70)
                              : Platform.isWindows
                                  ? const EdgeInsets.only(top: 0)
                                  : const EdgeInsets.only(top: 0)),
                      keyboardOn
                          ? const SizedBox.shrink()
                          : const SizedBox(
                              height: 250,
                              width: 250,
                              child: Image(
                                image:
                                    AssetImage('assets/foreground_windows.png'),
                              ),
                            ),
                      const Gap(20),
                      Text(
                        locale.schoolDataHub,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      keyboardOn
                          ? const SizedBox(
                              height: 15,
                            )
                          : const SizedBox(
                              height: 30,
                            ),
                      if (envReady) ...<Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 380),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8),
                            child: TextField(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              controller: controller.usernameController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: locale.userName,
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromRGBO(74, 76, 161, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 380),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8),
                            child: TextField(
                              textDirection: null,
                              controller: controller.passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: locale.password,
                                labelStyle: const TextStyle(
                                  color: Color.fromRGBO(74, 76, 161, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            //margin: const EdgeInsets.only(bottom: 16),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: actionButtonStyle,
                              onPressed: () async {
                                // locator<EnvManager>().deleteEnv();
                                await controller.loginWithTextCredentials();
                              },
                              child: Text(
                                locale.logInButtonText,
                                style: const TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            //margin: const EdgeInsets.only(bottom: 16),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: actionButtonStyle,
                              onPressed: () async {
                                await confirmationDialog(
                                    context,
                                    locale.deleteKeyPrompt,
                                    locale.areYouSureYouWantToDeleteSchoolKey);
                                locator<EnvManager>().deleteEnv();
                              },
                              child: Text(
                                locale.deleteKeyButtonText,
                                style: const TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                      if (envReady == false) ...<Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Platform.isWindows
                                ? Text(
                                    locale.importSchoolDataToContinue,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                : Text(
                                    locale.scanSchoolIdToContinue,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          //margin: const EdgeInsets.only(bottom: 16),
                          child: ElevatedButton(
                              style: actionButtonStyle,
                              onPressed: () async {
                                envReady
                                    ? controller.scanCredentials(context)
                                    : Platform.isWindows
                                        ? controller.importEnvFromTxt()
                                        : controller.scanEnv(context);
                              },
                              child: Platform.isWindows
                                  ? Text(locale.chooseFileButton,
                                      style: buttonTextStyle)
                                  : Text(
                                      locale.scanButton,
                                      style: buttonTextStyle,
                                    )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
