import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontendmobile/components/home_tile.dart';
import 'package:frontendmobile/components/large_home_tile.dart';
import 'package:frontendmobile/data/api_abstraction/api_commons.dart';
import 'package:frontendmobile/data/api_abstraction/storage_utils.dart';
import 'package:frontendmobile/data/api_data_classes/child.dart';
import 'package:frontendmobile/data/childEndpoint.dart';
import 'package:frontendmobile/other/changeColor.dart';
import 'package:frontendmobile/other/providers.dart';

import 'login_view_dynamic.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ChildEndpoint().push(ChildData());
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
            children: const [
              Expanded(child: PreparedGridView()),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: LargeHomeTile(
                    onTapPath: "/student_view",
                    iconName: Icons.accessibility,
                    title: "Title",
                    subtitle: "Subtitle"),
              ),
              Padding(
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
            title: "Title",
            subtitle: "Subtitle");
      },
    ).build(context);
  }
}

class PreparedGridView extends StatelessWidget {
  const PreparedGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width ~/ 180,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.only(left: 10, right: 10),
      children: const [
        HomeTile(
          title: "title",
          path: "/night_nusery_view",
          subtitle: "subtitle",
          iconName: Icons.accessibility,
        ),
        HomeTile(
          title: "title",
          path: "/night_nusery_view",
          subtitle: "subtitle",
          iconName: Icons.accessibility,
        ),
        //Presence(currentItem: SelectedItem.notSelected,),
        HomeTile(
          title: "title",
          path: "/night_nusery_view",
          subtitle: "subtitle",
          iconName: Icons.accessibility,
        )
      ],
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
