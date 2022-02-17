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
  const MyApp({Key? key}) : super(key: key);

  static var log = Logger();

  Future<int> getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late int valorColor;
    if(prefs.containsKey("1")){
      valorColor = prefs.getInt("1")!;
    }
    else{
      valorColor = 0xFF214A1F;
    }
    return valorColor;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v("Booting app...");
    SharedPrefsStorage<String>.primitive(itemKey: "serverIP").save("http://148.60.11.219");
    log.v("Auto sync");
    ApiCommons.sendToBack();
    final settings = ref.watch(settingsProvider);
    return ProviderScope(
      child: FutureBuilder<int>(
          future: getData(),
          builder: (context, snapshot) {
            if(snapshot.data != null){
              settings.updateIntColor(snapshot.requireData);
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      appBarTheme: AppBarTheme(
                        color: settings.colorSelected,
                      )),
                  initialRoute: '/',
                  onGenerateRoute: RouteGenerator.routes);
            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
        }
      ),
    );
  }
}
