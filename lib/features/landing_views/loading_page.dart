import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:watch_it/watch_it.dart';

class LoadingPage extends WatchingStatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    final NotificationData snackBarData =
        watchValue((NotificationManager x) => x.notification);
    // registerHandler(
    //     select: (SnackBarManager x) => x.snackBar,
    //     handler: (context, value, cancel) {
    //       snackbar(context, value.type, value.message);
    //     });
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: backgroundColor,
        ),
        child: Center(
          child: SizedBox(
            height: 500,
            width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 300,
                  width: 300,
                  child: Image(
                    image: AssetImage('assets/foreground.png'),
                  ),
                ),
                const Text(
                  "Schuldaten Hub",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const Spacer(),
                Text(snackBarData.message,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const Gap(30),
                const CircularProgressIndicator(
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
