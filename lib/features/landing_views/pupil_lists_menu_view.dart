import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/landing_views/pupil_lists_buttons.dart';

class PupilMenuView extends StatelessWidget {
  const PupilMenuView({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Kinderlisten',
          style: appBarTextStyle,
          textAlign: TextAlign.end,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
        child: Center(
          child: SizedBox(
            width: Platform.isWindows ? 600 : 600,
            height: Platform.isWindows ? 600 : 800,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [...pupilListButtons(context, screenWidth)])

                // GridView.count(
                //   shrinkWrap: true,
                //   crossAxisCount: screenWidth < 400
                //       ? 2
                //       : screenWidth < 700
                //           ? 3
                //           : 4,
                //   padding: const EdgeInsets.all(20),
                //   physics: const NeverScrollableScrollPhysics(),
                //   children: [
                //     ...pupilListButtons(context, screenWidth),
                //   ],
                // ),
                ),
          ),
        ),
      ),
    );
  }
}
