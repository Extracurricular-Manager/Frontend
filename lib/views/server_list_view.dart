

import 'package:flutter/material.dart';
import 'package:frontendmobile/data/api_abstraction/network_utils.dart';

import '../main.dart';

class ServerListView extends StatelessWidget {
  const ServerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  color: MyApp.AppColor),),
                ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const makeListTile(cityName: "Saint-Ganton", serverUrl: "http://148.60.11.219/");
                },
              )],
            ),
          ),)),
        backgroundColor: MyApp.AppColor
    );
  }

}


class makeListTile extends StatefulWidget {
  final String cityName;
  final String serverUrl;

  const makeListTile({Key? key, required this.cityName, required this.serverUrl}) : super(key: key);

  @override
  _makeListTile createState() => _makeListTile();
}

class _makeListTile extends State<makeListTile>{
  final GlobalKey<_listItemNetworkIndicator> _key = GlobalKey();

  @override
    Widget build(BuildContext context) {
    NetworkStatus? netState;
    StatefulWidget networkState = listItemNetworkIndicator(key:_key,ns: netState,);
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
  listItemNetworkIndicator({Key? key, this.ns}) : super(key: key);

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
          return const Text("En ligne", style:TextStyle(color:MyApp.AppColor));
      }

    }
  }

