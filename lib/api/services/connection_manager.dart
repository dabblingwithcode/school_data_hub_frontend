import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';

class ConnectionManager {
  ValueListenable<Stream<List<ConnectivityResult>>> get connectivity =>
      _connectivity;

  final _connectivity = ValueNotifier<Stream<List<ConnectivityResult>>>(
      Connectivity().onConnectivityChanged);

  ConnectionManager() {
    logger.i('ConnectionManager constructor called');
  }

  Future checkConnectivity() async {
    _connectivity.value = _connectivity.value;
    final connection = await (Connectivity().checkConnectivity());
    return connection;
    // //_connectivity.value = connection;
  }
}
