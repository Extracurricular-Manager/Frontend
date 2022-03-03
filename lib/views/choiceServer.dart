import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontendmobile/other/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class choiceServer extends ConsumerStatefulWidget {
  const choiceServer({Key? key}) : super(key: key);

  @override
  _LoginViewDynamic createState() => _LoginViewDynamic();
}

class _LoginViewDynamic extends ConsumerState<choiceServer> {
  FocusNode myFocusNode = new FocusNode();

  var listServers;

  @override
  void initState() {
    super.initState();
  }

  getServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listServers = prefs.getStringList("listServer");
    return listServers;
  }

  choiceServer(String server) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("server", server);
  }

  deleteServer(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var servs = prefs.getStringList("listServer");
    servs?.removeAt(index);
    prefs.setStringList("listServer", servs!);
  }

  getData(String server) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late int valorColor;
    var url = "Color" + server;
    if(prefs.containsKey(url)){
      valorColor = prefs.getInt(url)!;
    }
    else{
      valorColor = 0xFF214A1F;
    }
    return valorColor;
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: settings.colorSelected,
        body: FutureBuilder<dynamic>(
            future: getServer(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Center(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              "Sélectionner un serveur",
                              style: TextStyle(
                                  fontSize:
                                  23 * MediaQuery.of(context).textScaleFactor,
                                  fontWeight: FontWeight.bold,
                                  color: settings.colorSelected),
                            ),
                            ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Row(
                                      children: [
                                        Text(snapshot.data[index]),
                                        TextButton(
                                            onPressed: () => {
                                              settings.updateIntColor(getData(snapshot.data[index])),
                                              choiceServer(snapshot.data[index]),
                                              Navigator.popAndPushNamed(
                                                  context, '/connectDirect'), //login_view
                                            },
                                            child: Text("Selectionner")),
                                        IconButton(
                                            onPressed: () => {
                                              deleteServer(index),
                                              Navigator.popAndPushNamed(
                                                  context, '/login_view')
                                            },
                                            icon: Icon(Icons.delete))
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ));
              }
              else{
                return Center(child: CircularProgressIndicator(
                  backgroundColor: settings.colorSelected,
                ));
              }
            })
        );
  }
}

