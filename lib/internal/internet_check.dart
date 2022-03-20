import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isExistConnection() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  switch (connectivityResult) {
    case ConnectivityResult.mobile:
    case ConnectivityResult.wifi:
    case ConnectivityResult.ethernet:
      return true;
    case ConnectivityResult.bluetooth:
    default:
      return false;
  }
}
