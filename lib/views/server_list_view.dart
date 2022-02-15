

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontendmobile/data/api_abstraction/network_utils.dart';
import 'package:frontendmobile/other/providers.dart';

import '../main.dart';

class ServerListView extends ConsumerWidget {
  const ServerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
        body:Center(child:
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
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return makeListTile(cityName: "Saint-Ganton", serverUrl: "http://148.60.11.219/", choicecolor: settings.colorSelected);
                },
              )],
            ),
          ),)),
        backgroundColor: settings.colorSelected
    );
  }

}


class makeListTile extends StatefulWidget {
  final String cityName;
  final String serverUrl;
  final Color choicecolor;

  const makeListTile({Key? key, required this.cityName, required this.serverUrl, required this.choicecolor}) : super(key: key);

  @override
  _makeListTile createState() => _makeListTile();
}

class _makeListTile extends State<makeListTile>{
  final GlobalKey<_listItemNetworkIndicator> _key = GlobalKey();

  @override
    Widget build(BuildContext context) {
    NetworkStatus? netState;
    StatefulWidget networkState = listItemNetworkIndicator(key:_key,ns: netState,choicecolor:widget.choicecolor);
    NetworkUtils.getConnectivity(serverUrl: widget.serverUrl).then((val) => {
      _key.currentState?.updateData(val)});

    return ListTile(
        title:Text(widget.cityName),
        subtitle:networkState,
        onTap: () => Navigator.popAndPushNamed(context, "/login_view"));
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

