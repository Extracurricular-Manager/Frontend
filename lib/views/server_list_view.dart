import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontendmobile/data/api_abstraction/network_utils.dart';
import 'package:frontendmobile/other/listColor.dart';
import 'package:frontendmobile/other/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServerListView extends ConsumerWidget {
   ServerListView({Key? key}) : super(key: key);

  var listServers;

  getServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listServers = prefs.getStringList("listServer");
    return listServers;
  }

  deleteServer(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var servs = prefs.getStringList("listServer");
    servs?.removeAt(index);
    prefs.setStringList("listServer", servs!);
    var nameServs = prefs.getStringList("locationServer");
    nameServs?.removeAt(index);
    prefs.setStringList("locationServer", nameServs!);
  }

  getNameServer() async{ //locationServer
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var servs = prefs.getStringList("locationServer");
    return servs;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
        body:FutureBuilder<dynamic>(
            future: getServer(),
          builder: (context, snapshot) {
              if(snapshot.hasData){
                return FutureBuilder<dynamic>(
                    future: getNameServer(),
                    builder: (context, snapshot1) {
                      if(snapshot1.hasData){
                        return Center(child:
                        Card(child:
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [Text("Sélectionner un serveur", style: TextStyle(
                                fontSize: 23 * MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.bold,
                                color: settings.colorSelected),),
                              ListView.builder(
                                itemCount: snapshot.data.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      makeListTile(cityName: snapshot1.data![index], serverUrl: snapshot.data[index], choicecolor: settings.colorSelected),
                                      IconButton(
                                          onPressed: () => {
                                            deleteServer(index),
                                            Navigator.pushNamed(
                                                context, '/choice')
                                          },
                                          icon: Icon(Icons.delete))
                                    ],
                                  );
                                },
                              )],
                          ),
                        ),));
                      }
                      else{
                        return Center(child: CircularProgressIndicator(
                          backgroundColor: settings.colorSelected,
                        ));
                      }

                    }
                );
              }
              else{
                return Center(child: CircularProgressIndicator(
                  backgroundColor: settings.colorSelected,
                ));
              }

          }
        ),
        backgroundColor: settings.colorSelected
    );
  }
}


class makeListTile extends ConsumerStatefulWidget {
  final String cityName;
  final String serverUrl;
  final Color choicecolor;

  const makeListTile({Key? key, required this.cityName, required this.serverUrl, required this.choicecolor}) : super(key: key);

  @override
  _makeListTile createState() => _makeListTile();
}

class _makeListTile extends ConsumerState<makeListTile>{
  final GlobalKey<_listItemNetworkIndicator> _key = GlobalKey();

  choiceServer(String server) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("server", server);
  }

   getData(String server) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late int valorColor;
    var url = "Color" + server;
    if(prefs.containsKey(url)){
      valorColor = 0xFF214A1F;//prefs.getInt(url)!;
    }
    else{
      valorColor = 0xFF214A1F;
    }
    return valorColor;
  }

  @override
    Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    NetworkStatus? netState;
    StatefulWidget networkState = listItemNetworkIndicator(key:_key,ns: netState,choicecolor:widget.choicecolor);
    NetworkUtils.getConnectivity(serverUrl: widget.serverUrl).then((val) => {
      _key.currentState?.updateData(val)});

    return ListTile(
        title:Text(widget.cityName),
        subtitle:networkState,
        onTap: () => {
         /* settings.updateIntColor(getData(widget.serverUrl).hashCode),
          settings.updateColorSelected(Item("perso", Color(getData(widget.serverUrl).hashCode))),*/
          choiceServer(widget.serverUrl),
          Navigator.pushNamed(context, "/connectDirect"), //login_view
        }
    );
  }
}

class listItemNetworkIndicator extends StatefulWidget {
  NetworkStatus? ns;
  final Color choicecolor;
  listItemNetworkIndicator({Key? key, this.ns, required this.choicecolor}) : super(key: key);

  @override
  _listItemNetworkIndicator createState() => _listItemNetworkIndicator();
}

class _listItemNetworkIndicator extends State<listItemNetworkIndicator>{
    void updateData(NetworkStatus newNs){
      setState(() {
        widget.ns = newNs;
      });
    }
    @override
    Widget build(BuildContext context) {

      switch (widget.ns){

        case null:
        return const Text("Chargement");
        case NetworkStatus.none:
          return const Text("Réseau indisponible");
        case NetworkStatus.notAccessible:
          return const Text("Serveur inaccessible", style:TextStyle(color:Colors.red));
        case NetworkStatus.ok:
          return Text("En ligne", style:TextStyle(color:widget.choicecolor));
      }

    }
  }