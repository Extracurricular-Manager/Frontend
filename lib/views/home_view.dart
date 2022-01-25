
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontendmobile/components/home_tile.dart';
import 'package:frontendmobile/components/large_home_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
              title: const Text("Accueil",
                  style:TextStyle(
                      fontWeight: FontWeight.bold,
                  fontSize: 20)),
              backgroundColor: const Color(0xFF214A1F),
              shadowColor: Colors.transparent,
            actions: [ Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.sensor_door_outlined,
                      size: 26.0,
                    ),
                  )
              )
              ,
            )
            ]
        ),
        body: Stack(children: [
          Column(
            children: const [
               Expanded(child:PreparedGridView()
              ),
              Padding(
                padding: EdgeInsets.only(left:8,right:8),
                child: LargeHomeTile(),
            ),
            Padding(
              padding: EdgeInsets.only(top:8,bottom:22),
              child: Text("Dernière mise à jour il y a 5 minutes"),
            )],
          ),

          Ink(
            width:MediaQuery.of(context).size.width,
            height: 100,
            decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
                color: Color(0xFF214A1F),
          ),)
        ]));
  }
}


class PreparedListView extends StatelessWidget {
  const PreparedListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = ["","","",""];
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: list.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = list[index];
        return const LargeHomeTile();
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
      crossAxisCount: MediaQuery.of(context).size.width~/180,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.only(left:10,right:10),
      children: const [HomeTile(),HomeTile(),HomeTile()],);
  }
}