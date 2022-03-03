import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontendmobile/data/api_abstraction/api_commons.dart';
import 'package:frontendmobile/routes.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_item_shared_prefs/single_item_shared_prefs.dart';
import 'package:workmanager/workmanager.dart';
import 'other/providers.dart';
import 'package:http/http.dart' as http;

void main() {
  DartPingIOS.register();
  runApp(ProviderScope(child: MyApp()));

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
      true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  Workmanager().registerPeriodicTask("1", "Background Push",
      frequency: const Duration(minutes: 15));
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    return ApiCommons.sendToBack();
  });
}

class MyApp extends ConsumerWidget  {
   MyApp({Key? key}) : super(key: key);

  static var log = Logger();



   Future<bool> fetchServices() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? url = prefs.getString("server");
     String key = prefs.getString(url!)!;
     final response = await http.get(
       Uri.parse(url + '/api/token_validation'),
       headers: {
         'authorization': 'Bearer ' + key,
       },
     );
     if (response.statusCode == 200) {
       return true;
     }
     else {
       return false;
     }
   }

  late int lengthEcole = 0;
  late String chemin = "";

  Future<int> getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late int valorColor = 0xFF214A1F;
    var url;
    if(prefs.containsKey("server")){
       url = "Color" + prefs.getString("server")!;
      if(prefs.containsKey(url)){
        valorColor = prefs.getInt(url)!;
      }
    }
    else{
      valorColor = 0xFF214A1F;
    }
    if(!prefs.containsKey("listServer")){
      lengthEcole = 0;
    }
    else{
      lengthEcole = prefs.getStringList("listServer")!.length;
    }
    return valorColor;
  }

  getServer() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("server", prefs.getStringList("listServer")!.first);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v("Booting app...");
    //SharedPrefsStorage<String>.primitive(itemKey: "serverIP").save("http://148.60.11.219");
    log.v("Auto sync");
    ApiCommons.sendToBack();
    final settings = ref.watch(settingsProvider);
    return ProviderScope(
      child: FutureBuilder<int>(
          future: getData(),
          builder: (context, snapshot) {
            if(snapshot.data != null){
              if(lengthEcole == 0){
                chemin = "/addServer";
              }
              else if(lengthEcole == 1){
                getServer();
                chemin = "/connectDirect";
                //chemin = "/login_view";
              }
              else{
                chemin = "/choice";
              }
              settings.updateIntColor(snapshot.data!);
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      appBarTheme: AppBarTheme(
                        color: settings.colorSelected,
                      )),
                  initialRoute: chemin,
                  onGenerateRoute: RouteGenerator.routes);
            }
            else{
              return const Center(child: CircularProgressIndicator());
              //return Text("DATA");
            }
        }
      ),
    );
  }
}
