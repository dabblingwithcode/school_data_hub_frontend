import 'dart:convert';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/scanner.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/features/landing_views/loading_page.dart';
import 'package:schuldaten_hub/features/landing_views/login_view/login_view.dart';
import 'package:watch_it/watch_it.dart';

class Login extends WatchingStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginController createState() => LoginController();
}

class LoginController extends State<Login> {
  //final Env env = locator<EnvManager>().env.value;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  scanCredentials(BuildContext context) async {
    final String? scanResponse = await scanner(context, 'Zugangscode scannen');
    if (scanResponse != null) {
      final loginData = await json.decode(scanResponse);
      final username = loginData['username'];
      final password = loginData['password'];
      attemptLogin(username, password, context);
    } else {
      if (context.mounted) {
        snackbarWarning(context, 'Scanvorgang abgebrochen');
      }
      return;
    }
  }

  scanEnv(BuildContext context) async {
    final String? scanResponse = await scanner(context, 'Schul-Id scannen');
    if (scanResponse != null) {
      locator<EnvManager>().setEnv(scanResponse);
      if (context.mounted) {
        snackbarSuccess(context, 'Schul-Id erfolgreich importiert!');
      }
      return;
    } else {
      if (context.mounted) {
        snackbarWarning(context, 'Scanvorgang abgebrochen');
      }
      return;
    }
  }

  textFieldCredentials(BuildContext context) {
    String username = usernameController.text;
    String password = passwordController.text;
    attemptLogin(username, password, context);
  }

  attemptLogin(String username, String password, BuildContext context) async {
    bool isAuthenticated =
        await locator<SessionManager>().attemptLogin(username, password);
    if (isAuthenticated == true) {
      if (context.mounted) {
        snackbarSuccess(context, 'Login erfolgreich!');
      }
    } else {
      if (context.mounted) {
        snackbarWarning(context, 'Login fehlgeschlagen!');
      }
    }
  }

  importEnvFromTxt() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String rawTextResult = await file.readAsString();
      locator<EnvManager>().setEnv(rawTextResult);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locator.allReady(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LoginView(this);
        } else {
          return const LoadingPage();
        }
      },
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
