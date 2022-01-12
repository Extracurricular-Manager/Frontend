
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontendmobile/components/home_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:
        AppBar(
              title: const Text("Accueil",
                  style:TextStyle(
                      fontWeight: FontWeight.bold,
                  fontSize: 20)),
              backgroundColor: Colors.green,
              shadowColor: Colors.transparent,),
        body: Stack(children: [
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.only(left:10,right:10),
            children: const [HomeTile(),HomeTile(),HomeTile(),HomeTile(),HomeTile()],)
          ,
          Ink(
            width:500,
            height: 100,
            decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
                color:Colors.green
          ),)
        ]));
  }
}