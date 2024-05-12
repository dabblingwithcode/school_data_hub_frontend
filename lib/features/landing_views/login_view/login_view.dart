import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/landing_views/login_view/controller/login_controller.dart';

import 'package:watch_it/watch_it.dart';

class LoginView extends WatchingWidget {
  final LoginController controller;
  const LoginView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    registerHandler(
      select: (NotificationManager x) => x.notification,
      handler: (context, value, cancel) =>
          snackbar(context, value.type, value.message),
    );
    bool isAuthenticated = watchValue((SessionManager x) => x.isAuthenticated);
    bool envReady = watchValue((EnvManager x) => x.envReady);

    debug.warning('LoginView: isAuthenticated: ${isAuthenticated.toString()}');
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
                      const Text(
                        "Schuldaten Hub",
                        style: TextStyle(
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
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Benutzername',
                                labelStyle: TextStyle(
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
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Passwort',
                                labelStyle: TextStyle(
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
                              child: const Text(
                                "EINLOGGEN",
                                style: TextStyle(
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
                                    "Schulschlüssel löschen?",
                                    "Sind Sie sicher, dass Sie die Schuldaten löschen möchten?");
                                locator<EnvManager>().deleteEnv();
                              },
                              child: const Text(
                                "SCHULSCHLÜSSEL LÖSCHEN",
                                style: TextStyle(
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
                                ? const Text(
                                    'Schul-ID importieren, um fortfahren zu können.',
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                : const Text(
                                    'Schul-ID scannen, um fortfahren zu können.',
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
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
                                  ? const Text('DATEI AUSWÄHLEN',
                                      style: buttonTextStyle)
                                  : const Text(
                                      "SCANNEN",
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
