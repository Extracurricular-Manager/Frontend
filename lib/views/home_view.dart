import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontendmobile/components/home_tile.dart';
import 'package:frontendmobile/components/large_home_tile.dart';
import 'package:frontendmobile/data/api_abstraction/api_commons.dart';
import 'package:frontendmobile/data/api_abstraction/storage_utils.dart';
import 'package:frontendmobile/data/api_data_classes/child.dart';
import 'package:frontendmobile/data/api_data_classes/services.dart';
import 'package:frontendmobile/data/childEndpoint.dart';
import 'package:frontendmobile/other/changeColor.dart';
import 'package:frontendmobile/other/providers.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontendmobile/data/api_data_classes/token.dart';


class HomeView extends ConsumerWidget {

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ChildEndpoint().push(ChildData());
    final settings = ref.watch(settingsProvider);
    return Scaffold(
        appBar: AppBar(
            title: const Text("Accueil"),
            shadowColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login_view');
              },
              icon: const Icon(Icons.sensor_door_outlined),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                    )),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ColorSettingsPage();
                        })
                },
              ),
            ]),
        body: Stack(children: [
          Column(
            children:  [
              Expanded(child: PreparedGridView(color: settings.colorSelected)),
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: LargeHomeTile(
                    onTapPath: "/student_view",
                    iconName: Icons.accessibility,
                    title: "Liste des élèves",
                    subtitle: "Récapitulatif"),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 22),
                child: ButtomSyncStatusWidget(),
              ),
            ],
          ),
          Ink(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: settings.colorSelected,
            ),
          )
        ]));
  }
}
/*
class PreparedListView extends StatelessWidget {
  const PreparedListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = ["", "", "", ""];
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: list.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        return const LargeHomeTile(
            onTapPath: "/student_view",
            iconName: Icons.accessibility,
            title: "Title1",
            subtitle: "Récapitulatif");
      },
    ).build(context);
  }
}*/

class PreparedGridView extends StatefulWidget {
  var color;

   PreparedGridView({
    Key? key, required this.color
  }) : super(key: key);

  @override
  State<PreparedGridView> createState() => _PreparedGridViewState();
}

class _PreparedGridViewState extends State<PreparedGridView> {

  Map<String, IconData> iconMap = {
    "child_care": Icons.child_care,
    "wb_sunny": Icons.wb_sunny,
    "emoji_events": Icons.emoji_events,
    "sports_handball": Icons.sports_handball,
    "sports_esports": Icons.sports_esports,
    "local_hospital ": Icons.local_hospital ,
    "restaurant": Icons.restaurant,
    "celebration": Icons.celebration,
    "luggage": Icons.luggage,
    "bedtime": Icons.bedtime,
    "castle": Icons.restaurant,
    "games": Icons.games,
  };

  List<Services> parseServices(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Services>((json) => Services.fromJson(json)).toList();
  }

  Future<List<Services>> fetchServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString("server");
    String key = prefs.getString(url!)!;
    final response = await http.get(
        Uri.parse(url + '/api/services'),
        headers: {
          'authorization': 'Bearer ' + key,
        },
    );
    if (response.statusCode == 200) {
      return parseServices(response.body);
    }
    else {
      throw Exception('Failed to load album');
    }
  }

  late final Future<List<Services>> myServices;

  @override
  void initState() {
    super.initState();
    myServices = fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Services>>(
        future: myServices,
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width ~/ 180,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext ctx, index) {
                String chemin;
                if(snapshot.data![index].model == 'presence'){
                    chemin = "/canteen_view";
                }
                else{
                    chemin = "/day_nursery_view";
                }
                //IconData test = IconData() as IconData; //snapshot.data![index].icon.
                return HomeTile(
                  title: snapshot.data![index].name,
                  path: chemin,
                  subtitle: snapshot.data![index].model == "period" ? "Horaire" : "Présence",
                  iconName: iconMap[snapshot.data![index].icon]!,//portrait,
                  idService:  snapshot.data![index].id,
                  nameService: snapshot.data![index].name,
                );
              },
            );
          }
          else{
            return Center(child: CircularProgressIndicator(
              backgroundColor: widget.color,
            ));
          }
      }
    );
  }
}

class ButtomSyncStatusWidget extends StatefulWidget {
  const ButtomSyncStatusWidget({Key? key}) : super(key: key);

  @override
  _ButtomSyncStatusWidget createState() => _ButtomSyncStatusWidget();
}

class _ButtomSyncStatusWidget extends State<ButtomSyncStatusWidget> {
  late SyncStatus status = SyncStatus.notNeeded;
  late int itemsToSync = 0;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    StorageUtils().getDefaultVaultSize().then((value) => itemsToSync = value);
    ApiCommons.status.listen((event) {
      setState(() {
        status = event;
      });
    });
    StorageUtils.vaultSize.listen((event) {
      setState(() {
        itemsToSync = event;
      });
    });
    return syncStatusText(status);
  }

  Widget syncStatusText(SyncStatus stat) {
    switch (stat) {
      case SyncStatus.notNeeded:
        return const Text("Aucun élément à synchroniser");
      case SyncStatus.needed:
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("$itemsToSync Élément${itemsToSync > 1 ? 's' : ''} en attente"),
          syncTextButton()
        ]); //ajouter bouton de sync
      case SyncStatus.prepaing:
        return const Text("Préparation pour la synchronisation");
      case SyncStatus.syncing:
        return Text(
            "Synchronisation en cours, $itemsToSync élément${itemsToSync > 1 ? 's' : ''} restant${itemsToSync > 1 ? 's' : ''}");
    }
  }

  TextButton syncTextButton() {
    return TextButton(
      onPressed: () => ApiCommons.sendToBack(),
      child: const Text("Synchroniser",
          style: TextStyle(color: Colors.blueAccent)),
    );
  }
}
