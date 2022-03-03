import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontendmobile/data/api_abstraction/network_utils.dart';
import 'package:frontendmobile/data/api_data_classes/user.dart';
import 'package:frontendmobile/other/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;


class addServer extends ConsumerStatefulWidget {

  const addServer({Key? key}) : super(key: key);

  @override
  _LoginViewDynamic createState() => _LoginViewDynamic();
}

class _LoginViewDynamic extends ConsumerState<addServer> {

  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: settings.colorSelected,
        body: Center(
            child:
            userViewBuilder(settings.colorSelected)
        ));
  }

  String error = "";
  final urlServer = TextEditingController();
  final location = TextEditingController();
  bool SignUp = false;

  @override
  void dispose() {
    urlServer.dispose();
    location.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      error = '';
      urlServer.text = '';
      location.text = '';
      SignUp = false;
    });
  }

  Widget userViewBuilder(Color colorSelected) {
    return Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Text("Ajouter un serveur",
                  style: TextStyle(
                      fontSize: 23 * MediaQuery.of(context).textScaleFactor,
                      fontWeight: FontWeight.bold,
                      color: colorSelected)),
              TextFormField(
                controller: location,
                focusNode: myFocusNode1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: colorSelected, width: 2.0),
                    ),
                    labelText: "Lieu",
                    labelStyle: TextStyle(
                      color: myFocusNode1.hasFocus ? colorSelected : Colors.grey,
                    )
                ),
              ),
              TextFormField(
                //controller: IdController,
                controller: urlServer,
                focusNode: myFocusNode,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: colorSelected, width: 2.0),
                    ),
                    labelText: "URL Serveur",
                    labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? colorSelected : Colors.grey,
                    )
                ),
              ),
              Wrap(
                spacing: 8,
                direction: Axis.horizontal,
                children: [
                  MaterialButton(
                    color: colorSelected,
                    child: const Text("Ajouter"),
                    textColor: Colors.white,

                    onPressed: () => {
                      add(urlServer.value.text, location.value.text),
                      Navigator.popAndPushNamed(context, '/login_view')
                    },
                  ),
                  MaterialButton(
                    color: Colors.white,
                    child: const Text("Annuler"),
                    textColor: colorSelected,
                    onPressed: () => Navigator.popAndPushNamed(context, '/login_view'),
                  ),
                ],
              )
            ],
          ),
        ));
    }

    add(String URL, String location) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var listServ = prefs.getStringList("listServer");
      var locationServ = prefs.getStringList("locationServer");
      if(listServ != null && locationServ != null){
        listServ.add(URL);
        locationServ.add(location);
        prefs.setStringList("listServer", listServ);
        prefs.setStringList("locationServer", locationServ);
        prefs.setString("server", URL);
      }
      else{
        prefs.setStringList("listServer", [URL]);
        prefs.setStringList("locationServer", [location]);
      }

    }
  }





