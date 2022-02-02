import 'package:flutter/material.dart';
import 'package:frontendmobile/routes.dart';
import 'package:frontendmobile/test/test_view.dart';

import 'data/api_abstraction/cache.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Cache().getVault("michel").then((value) => value.put("hello", "there"));
    Cache().getVault("michel").then((value) => value.put("bonjour", "ici"));
    Cache().getVault("michel").then((value) => value.size.then((value) => print(value)));
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
