import 'package:flutter/material.dart';

class LargeHomeTile extends StatelessWidget {
  const LargeHomeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap:(){},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
      elevation: 5,
    );
  }
}