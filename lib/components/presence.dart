import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Presence extends StatelessWidget {

  final SelectedItem currentItem;

  const Presence({Key? key, required this.currentItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(currentItem.getIconName, color: currentItem.getIconColor); // do I need to return text with it?
  }
}

enum SelectedItem {
  selected,
  partial,
  notSelected,
}

extension SelectedColorExtension on SelectedItem {
  String get name => describeEnum(this);

  IconData get getIconName {
    switch (this) {
      case SelectedItem.notSelected:
        return Icons.radio_button_unchecked;
      case SelectedItem.selected:
        return Icons.check_circle_outline;
      case SelectedItem.partial:
        return Icons.remove_circle_outline;
      default:
        return Icons.access_alarm;
    }
  }

  Color get getIconColor {
    switch (this) {
      case SelectedItem.notSelected:
        return Colors.red;
      case SelectedItem.selected:
        return const Color(0xFF045824);
      case SelectedItem.partial:
        return Colors.yellow;
      default:
        return Colors.black12;
    }
  }
}