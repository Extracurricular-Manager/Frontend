
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  const HomeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.accessibility, size: 30,),
            Text("Titre",
                style:TextStyle(
                    fontSize: 20,
                fontWeight: FontWeight.bold)),
            Spacer(),
            Text("sous-titre", style:TextStyle(color: Colors.grey))
          ],
        ),
      ),
      elevation: 5,
    );
  }
}