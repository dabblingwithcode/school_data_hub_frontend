import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';

class SnackBarData {
  final SnackBarType type;
  final String message;

  SnackBarData(this.type, this.message);
}

class SnackBarManager {
  ValueListenable<SnackBarData> get snackBar => _snackBar;
  ValueListenable<bool> get isRunning => _isRunning;
  final _snackBar =
      ValueNotifier<SnackBarData>(SnackBarData(SnackBarType.success, ''));
  final _isRunning = ValueNotifier<bool>(false);

  SnackBarManager();

  void showSnackBar(SnackBarType type, String message) {
    _snackBar.value = SnackBarData(type, message);
  }

  void isRunningValue(bool value) {
    _isRunning.value = value;
  }
}
