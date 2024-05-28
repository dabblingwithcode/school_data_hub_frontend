import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';

class NotificationData {
  final NotificationType type;
  final String message;

  NotificationData(this.type, this.message);
}

class NotificationManager {
  ValueListenable<NotificationData> get notification => _snackBar;
  ValueListenable<bool> get isRunning => _isRunning;
  final _snackBar = ValueNotifier<NotificationData>(
      NotificationData(NotificationType.success, ''));
  final _isRunning = ValueNotifier<bool>(false);

  NotificationManager();

  void showSnackBar(NotificationType type, String message) {
    _snackBar.value = NotificationData(type, message);
  }

  void isRunningValue(bool value) {
    _isRunning.value = value;
  }
}
