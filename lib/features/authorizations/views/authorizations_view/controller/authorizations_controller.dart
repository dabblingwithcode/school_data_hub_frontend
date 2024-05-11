import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorizations_view/authorizations_view.dart';

class Authorizations extends StatefulWidget {
  const Authorizations({
    Key? key,
  }) : super(key: key);

  @override
  AuthorizationsController createState() => AuthorizationsController();
}

class AuthorizationsController extends State<Authorizations> {
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    locator<AuthorizationManager>().fetchAuthorizations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthorizationsView(this);
  }
}
