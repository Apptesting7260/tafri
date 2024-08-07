import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  List<ConnectivityResult> _currentStatus = [ConnectivityResult.none];
  List<ConnectivityResult> get currentStatus => _currentStatus;

  InternetService() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((event) {
      _currentStatus = event;
      print('internet == ${_currentStatus}');
    },);
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }
}
