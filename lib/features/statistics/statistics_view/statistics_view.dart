import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/list_tiles/enrollment_list_tiles.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/list_tiles/group_list_tiles.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/list_tiles/languages_list_tiles.dart';
// ignore: directives_ordering
import 'package:schuldaten_hub/features/statistics/statistics_view/controller/statistics.dart';

class StatisticsView extends StatelessWidget {
  final StatisticsController controller;
  const StatisticsView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart_rounded, size: 25, color: Colors.white),
            Gap(10),
            Text('Statistik', style: appBarTextStyle),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 20),
            child: Column(
              children: [
                const Gap(15),
                const Row(
                  children: [
                    Text(
                      'Schulzahlen',
                      style: title,
                    )
                  ],
                ),
                const Gap(10),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        groupListTiles(context, controller),
                        languagesListTiles(context, controller),
                        enrollmentListTiles(context, controller)
                      ]),
                ))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(10),
        shape: null,
        color: backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Row(
              children: [
                IconButton(
                  tooltip: 'zurück',
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
