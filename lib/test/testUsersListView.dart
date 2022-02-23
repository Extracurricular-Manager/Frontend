import 'package:flutter/material.dart';
import 'package:frontendmobile/test/testGetUsersList.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestingGetUsersList(),
    );
  }
}