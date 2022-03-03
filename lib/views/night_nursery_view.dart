import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontendmobile/components/students_list.dart';
import 'package:frontendmobile/other/providers.dart';

class NightNurseryView extends ConsumerWidget {
  const NightNurseryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
   /* return StudentsList(
      title: 'Garderie Soir',
      students: students,
      choiceColor: settings.colorSelected,
    );*/
    return Text("data");
  }
}
