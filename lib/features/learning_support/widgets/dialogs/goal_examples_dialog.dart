import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/learning_support/models/goal/pupil_goal.dart';

void goalExamplesDialog(context, title, List<PupilGoal> goals) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Beispiele'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400, // Adjust height according to your requirement
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(goals.length, (index) {
                return Card(
                  color: cardInCardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text('Ziel:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: Text(goals[index].description!)),
                          ],
                        ),
                        const Row(
                          children: [
                            Text('Strategien:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: Text(goals[index].strategies!)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color.fromRGBO(74, 76, 161, 1),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
