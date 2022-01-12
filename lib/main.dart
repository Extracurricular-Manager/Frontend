import 'package:flutter/material.dart';
//import 'package:frontendmobile/routes.dart';
//import 'package:frontendmobile/views/pageeleve.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          color: Color(0xFF045824),
        )),
        //initialRoute: '/',
        //onGenerateRoute: RouteGenerator.routes,

        /* const PageEleve(
        title: '',
      ), */

        home: const Text("Home"));
  }
}
