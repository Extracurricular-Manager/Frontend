import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:flutter/material.dart';
import 'package:frontendmobile/routes.dart';
import 'package:frontendmobile/test/test_view.dart';

import 'data/api_abstraction/storage_utils.dart';

void main() {
  DartPingIOS.register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    StorageUtils().getVault("michel").then((value) => value.put("hello", "there"));
    StorageUtils().getVault("michel").then((value) => value.put("bonjour", "ici"));
    StorageUtils().getVault("michel").then((value) => value.size.then((value) => print(value)));
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
