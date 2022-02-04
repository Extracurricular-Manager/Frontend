import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:http/http.dart';
import 'package:single_item_shared_prefs/single_item_shared_prefs.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class NetworkUtils{

  static Future<bool> alreadyExists(String url) async{
    final response = await http.get(Uri.parse(url));
    return response.statusCode == HttpStatus.ok;
  }

  static Future<NetworkStatus> getConnectivity() async {
     var key = await SharedPrefsStorage<String>.primitive(itemKey: "serverIP").get();
     return Connectivity().checkConnectivity().then((value) => value != ConnectivityResult.none ? _ping(key as String) : _noNetworkStatus()
    );
  }

  static Future<NetworkStatus> _ping(String url) async {
    MyApp.log.d("ping de "+ url);
    NetworkStatus result = NetworkStatus.none;
    try{
      await http.get(Uri.parse(url))
          .then((value) => result = NetworkStatus.ok)
          .timeout(const Duration(seconds:10), onTimeout: ()=> result =  NetworkStatus.notAccessible);
    } catch(exception) {
      MyApp.log.d("Petit soucis lors du ping", exception);
    }
    MyApp.log.v(result);
    return result;
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