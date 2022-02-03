import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:single_item_shared_prefs/single_item_shared_prefs.dart';
import 'package:http/http.dart' as http;

class NetworkUtils{

  static Future<NetworkStatus> getConnectivity(){
    return SharedPrefsStorage.primitive(itemKey: "serverIP").get().then((iPKey) =>
      Connectivity().checkConnectivity().then((value) => value != ConnectivityResult.none ? _ping(iPKey as String) : _noNetworkStatus()
    ));
  }

  static Future<NetworkStatus> _ping(String url) async {
    return Ping(url, count: 1, timeout: 1).stream.first.then(
            (value) => value.error != null  ? NetworkStatus.notAccessible : NetworkStatus.ok );
  }

  static Future<NetworkStatus> _noNetworkStatus() async {
    return NetworkStatus.none;
  }

}

enum NetworkStatus {
  none,
  notAccessible,
  ok
}