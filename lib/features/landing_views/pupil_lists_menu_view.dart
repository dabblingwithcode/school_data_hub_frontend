import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/landing_views/pupil_lists_buttons.dart';

class PupilMenuView extends StatelessWidget {
  const PupilMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      primary: true,
      backgroundColor: canvasColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor,
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          locale.pupilLists,
          style: appBarTextStyle,
          textAlign: TextAlign.end,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: Platform.isWindows ? 700 : 600,
          height: Platform.isWindows
              ? 600
              : MediaQuery.of(context).size.height * 0.9,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            child: PupilListButtons(
              screenWidth: screenWidth,
            ),
          ),
        ),
      ),
    );
  }
}
