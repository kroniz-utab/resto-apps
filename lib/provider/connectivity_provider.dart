import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum ConnectionStatus { Online, Offline, Error }

class ConnectivityProvider extends ChangeNotifier {
  Connectivity _connectivity = Connectivity();

  late ConnectionStatus _status = ConnectionStatus.Offline;
  late String _message = '';
  ConnectionStatus get status => _status;
  String get message => _message;

  startMonitoring() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.none) {
        _status = ConnectionStatus.Offline;
        notifyListeners();
      } else {
        await _updateConnectionStatus().then((bool value) {
          _status = ConnectionStatus.Online;
          notifyListeners();
        });
      }
    });
  }

  Future<dynamic> initConnectivity() async {
    try {
      var result = await _connectivity.checkConnectivity();

      if (result == ConnectivityResult.none) {
        _status = ConnectionStatus.Offline;
        notifyListeners();
        return _message =
            'Your device is not connected to internet, Make sure your device connected to wifi/celular data first!';
      } else {
        _status = ConnectionStatus.Online;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      _status = ConnectionStatus.Error;
      notifyListeners();
      return _message = 'Platform Exception : $e';
    }
  }

  Future<bool> _updateConnectionStatus() async {
    late bool _isconnected;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('https://restaurant-api.dicoding.dev');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isconnected = true;
      }
    } on SocketException catch (_) {
      _isconnected = false;
    }

    return _isconnected;
  }
}
