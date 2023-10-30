// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../network/api_constants.dart';

enum ConnectivityStatus { WiFi, Cellular, Offline }

///Internet Connectivity
class NetworkConnection {
  NetworkConnection.__internal();
  static final NetworkConnection _instance = NetworkConnection.__internal();
  static NetworkConnection get instance => _instance;

  Future<bool> checkInternetConnection() async {
    bool checkConnection;
    try {
      final result = await InternetAddress.lookup(ApiConstants.googleLink)
          .timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        checkConnection = true;
      } else {
        checkConnection = false;
      }
    } on TimeoutException catch (_) {
      checkConnection = false;
    } on SocketException catch (_) {
      checkConnection = false;
    }
    return checkConnection;
  }

  Future<bool> checkInternet() async {
    bool checkConnection;
    try {
      final result = await InternetAddress.lookup(ApiConstants.googleLink);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        checkConnection = true;
      } else {
        checkConnection = false;
      }
    } on SocketException catch (_) {
      checkConnection = false;
    }
    return checkConnection;
  }
}

class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup(ApiConstants.googleLink);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}

class ConnectivityService {
  /// Create our public controller
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();
  ConnectivityService() {
    /// Subscribe to the connectivity Changed Stream
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  /// Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
