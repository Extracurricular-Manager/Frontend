import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontendmobile/other/providers.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'listColor.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ColorSettingsPage extends ConsumerStatefulWidget {
  ColorSettingsPage({Key? key}) : super(key: key);

  @override
  _ColorSettingsPageState createState() => _ColorSettingsPageState();
}

class _ColorSettingsPageState extends ConsumerState<ColorSettingsPage> {

  Color pickerColor = Color(0xFF214A1F);
  bool vision = false;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {

      return AlertDialog(
        title: Row(
          children: [
            Text('Choisis ta couleur!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: settings.colorSelected)),
            IconButton(
                onPressed: () => (
                    setState(() {
                      vision=!vision;
                    })
                ),
                icon: Icon(Icons.apps))
          ],
        ),
        content: SingleChildScrollView(
          child: Builder(
            builder: (context) {
              if(vision == false){
                return ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: changeColor,
                );
              }
              else{
                return MaterialPicker(
                  pickerColor: pickerColor,
                  onColorChanged: changeColor, // only on portrait mode
                );
              }
            }
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: settings.colorSelected,
            ),
            child: const Text('Valider'),
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var url = "Color" + prefs.getString("server")!;
              prefs.setInt(url, pickerColor.hashCode);
              Item choiceColor = Item("perso", pickerColor);
              settings.updateColorSelected(choiceColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
