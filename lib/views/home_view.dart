
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
              backgroundColor: Colors.green,
              shadowColor: Colors.transparent,
            actions: [ Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.exit_to_app,
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
            children: [
              Expanded(child:GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width~/200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.only(left:10,right:10),
                children: const [HomeTile(),HomeTile(),HomeTile(),HomeTile(),HomeTile()],)
              ),
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: const Padding(
                padding: EdgeInsets.only(left:8,right:8),
                child: LargeHomeTile(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top:8,bottom:22),
              child: Text("Dernière mise à jour il y a 5 minutes"),
            )],
          ),

          Ink(
            width:MediaQuery.of(context).size.width,
            height: 100,
            decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
                color:Colors.green
          ),)
        ]));
  }
}