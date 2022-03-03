import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontendmobile/other/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../routes.dart';

class directConnect extends ConsumerStatefulWidget {
  const directConnect({Key? key}) : super(key: key);

  @override
  _directConnectState createState() => _directConnectState();
}

class _directConnectState extends ConsumerState<directConnect> {

  Future<bool> fetchServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("ICI123");
    String? url = prefs.getString("server");
    print("ICI123456");
    String key;
    if(prefs.containsKey(url!)){
      key = prefs.getString(url)!;
    }
    else{
      return false;
    }
    print("ICI123567895441");
    print(url);
    print(key);
    final response = await http.get(
      Uri.parse(url + '/api/token_validation'),
      headers: {
        'authorization': 'Bearer ' + key,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      print("DEBUT");
      return true;
    } else {
      print("FIN");
      return false;
    }
  }

  Future<int> takeColor() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("1");
    var url = "Color" + prefs.getString("server")!;
    if(prefs.containsKey(url)){
      return prefs.getInt(url)!;
    }
    print("2");
    return 0xFF214A1F;
  }

  late String chemin = "";

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return FutureBuilder<bool>(
        future: fetchServices(),
        builder: (context, snapshot) {
          return FutureBuilder<int>(
              future: takeColor(),
              builder: (context, snapshot1) {
                if (snapshot.hasData) {
                  settings.updateIntColor(snapshot1.data!);
                  if (snapshot.data!) {
                    //Navigator.pushNamed(context, '/home_view');
                    chemin = '/home_view';
                  } else {
                    chemin = '/login_view';
                    //Navigator.pushNamed(context, '/login_view');
                  }
                  return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                          appBarTheme: AppBarTheme(
                        color: settings.colorSelected,
                      )),
                      initialRoute: chemin,
                      onGenerateRoute: RouteGenerator.routes);
                } else {
                  return const Center(
                      child: Text("data")); // CircularProgressIndicator());
                }
              });
        });
  }
}
