import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontendmobile/components/students_list.dart';
import 'package:frontendmobile/other/providers.dart';

class CanteenView extends ConsumerWidget {
  const CanteenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    List<String> students = [
      "Erreur d'affichage",
      "Arthur",
      "Curtis",
      "Theo",
      "Guillaume",
      "Sara"
    ];
    // ignore: prefer_const_constructors
    return StudentsList(
      title: "Canteen",
      students: students,
      choiceColor: settings.colorSelected,
    );
  }
}
