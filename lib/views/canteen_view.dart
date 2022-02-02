import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontendmobile/components/students_list.dart';
import 'package:frontendmobile/test/test_view.dart';

class CanteenView extends StatelessWidget {
  const CanteenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> students = [
      "Erreur d'affichage",
      "Arthur",
      "Curtis",
      "Theo",
      "Guillaume",
      "Sara"
    ];
    // ignore: prefer_const_constructors
    return TestView(
      title: "Testing",
      students: students,
    );
  }
}
