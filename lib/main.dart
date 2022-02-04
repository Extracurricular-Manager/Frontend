import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:flutter/material.dart';
import 'package:frontendmobile/data/api_abstraction/api_commons.dart';
import 'package:frontendmobile/routes.dart';
import 'package:frontendmobile/test/test_view.dart';
import 'package:logger/logger.dart';
import 'package:workmanager/workmanager.dart';

import 'data/api_abstraction/storage_utils.dart';

void main() {
  //Logger().v("Booting app...");
  DartPingIOS.register();
  runApp(const MyApp());

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static var log = Logger();
  @override
  Widget build(BuildContext context) {
    StorageUtils()
        .getVault("michel")
        .then((value) => value.put("hello", "there"));
    StorageUtils()
        .getVault("michel")
        .then((value) => value.put("bonjour", "ici"));
    StorageUtils()
        .getVault("michel")
        .then((value) => value.size.then((value) => print(value)));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          color: Color(0xFF214A1F),
        )),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.routes);

//        home: TestView());
  }
}
