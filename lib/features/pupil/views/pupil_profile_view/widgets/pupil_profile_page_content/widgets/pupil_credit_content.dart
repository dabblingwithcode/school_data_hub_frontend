import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/paddings.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/credit/credit_list_page.dart';

import 'package:schuldaten_hub/features/pupil/models/credit_history_log.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/credit/widgets/dialogues/change_credit_dialog.dart';

class PupilCreditContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilCreditContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: pupilProfileCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: pupilProfileCardPadding,
        child: Column(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(
              Icons.attach_money_rounded,
              color: accentColor,
              size: 24,
            ),
            const Gap(5),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const CreditListPage(),
                ));
              },
              child: const Text('Guthaben',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  )),
            ),
            const Spacer(),
            Text(
              pupil.credit.toString(),
              style: const TextStyle(
                  color: groupColor, fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const Gap(20),
          ]),
          //const Gap(15),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              //margin: const EdgeInsets.only(bottom: 16),
              width: double.infinity,
              child: ElevatedButton(
                style: successButtonStyle,
                onPressed: () async {
                  changeCreditDialog(context, pupil);
                },
                child: const Text(
                  "GUTHABEN ÄNDERN",
                  style: buttonTextStyle,
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Insgesamt verdient:',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
              const Gap(5),
              Text(pupil.creditEarned.toString(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
          const Gap(10),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 22),
                child: Text(
                  'Verlauf',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          ListView.builder(
            padding: const EdgeInsets.only(left: 20, top: 5, bottom: 15),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pupil.creditHistoryLogs!.length,
            itemBuilder: (BuildContext context, int index) {
              final List<CreditHistoryLog> pupilCreditHistoryLogs =
                  List.from(pupil.creditHistoryLogs!);
              // order by date latest first
              pupilCreditHistoryLogs
                  .sort((a, b) => b.createdAt.compareTo(a.createdAt));
              CreditHistoryLog creditHistoryLog = pupilCreditHistoryLogs[index];

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    //- TO-DO: change missed class function
                    //- like _changeMissedClassHermannpupilPage
                  },
                  onLongPress: () async {},
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('dd.MM.yyyy')
                                .format(creditHistoryLog.createdAt)
                                .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Gap(10),
                          const Text('Betrag:'),
                          const Gap(10),
                          Text(
                            creditHistoryLog.operation.toString(),
                            style: TextStyle(
                              color: creditHistoryLog.operation < 0
                                  ? Colors.red
                                  : groupColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Gap(10),
                          const Text('von:'),
                          const Gap(10),
                          Text(
                            creditHistoryLog.createdBy,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}

List<Widget> pupilCreditContentList(PupilProxy pupil, BuildContext context) {
  return [
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        //margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        child: ElevatedButton(
          style: successButtonStyle,
          onPressed: () async {
            changeCreditDialog(context, pupil);
          },
          child: const Text(
            "GUTHABEN ÄNDERN",
            style: buttonTextStyle,
          ),
        ),
      ),
    ),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Insgesamt verdient:',
          style: TextStyle(fontSize: 18.0),
          textAlign: TextAlign.left,
        ),
        const Gap(5),
        Text(pupil.creditEarned.toString(),
            style:
                const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
      ],
    ),
    const Gap(10),
    const Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 22),
          child: Text(
            'Verlauf',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    ),
    const Gap(10),
    ListView.builder(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pupil.creditHistoryLogs!.length,
      itemBuilder: (BuildContext context, int index) {
        final List<CreditHistoryLog> pupilCreditHistoryLogs =
            List.from(pupil.creditHistoryLogs!);
        // order by date latest first
        pupilCreditHistoryLogs
            .sort((a, b) => b.createdAt.compareTo(a.createdAt));
        CreditHistoryLog creditHistoryLog = pupilCreditHistoryLogs[index];

        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              //- TO-DO: change missed class function
              //- like _changeMissedClassHermannpupilPage
            },
            onLongPress: () async {},
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('dd.MM.yyyy')
                          .format(creditHistoryLog.createdAt)
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                    const Text('Betrag:'),
                    const Gap(10),
                    Text(
                      creditHistoryLog.operation.toString(),
                      style: TextStyle(
                        color: creditHistoryLog.operation < 0
                            ? Colors.red
                            : groupColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                    const Text('von:'),
                    const Gap(10),
                    Text(
                      creditHistoryLog.createdBy,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  ];
}
