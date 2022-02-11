import 'dart:async';

import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:flutter/material.dart';
import 'package:frontendmobile/data/api_abstraction/api_commons.dart';
import 'package:frontendmobile/routes.dart';
import 'package:frontendmobile/test/test_view.dart';
//import 'package:frontendmobile/views/login_view.dart';
import 'package:logger/logger.dart';
import 'package:single_item_shared_prefs/single_item_shared_prefs.dart';
import 'package:workmanager/workmanager.dart';

import 'data/api_abstraction/storage_utils.dart';

void main() {
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
  static const Color AppColor = Color(0xFF214A1F);
  @override
  Widget build(BuildContext context) {
    log.v("Booting app...");
    SharedPrefsStorage<String>.primitive(itemKey: "serverIP")
        .save("http://148.60.11.219");
    log.v("Auto sync");
    ApiCommons.sendToBack();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          color: AppColor,
        )),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.routes);
  }
}
