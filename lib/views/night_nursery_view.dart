import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontendmobile/components/students_list.dart';

class NightNurseryView extends StatelessWidget {
  const NightNurseryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> students = [
      "Erreur d'affichage",
      "Arthur",
      "Curtis",
      "Guillaume",
      "Sara"
    ];
    // ignore: prefer_const_constructors
    return StudentsList(
      title: 'Garderie Soir',
      students: students,
    );
  }
}
