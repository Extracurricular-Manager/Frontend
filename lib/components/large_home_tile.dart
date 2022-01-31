import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LargeHomeTile extends StatelessWidget {
  const LargeHomeTile({Key? key, required this.onTapPath}) : super(key: key);

  final String onTapPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 500),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, onTapPath);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.accessibility,
                  size: 30,
                ),
                Text("Titre",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Spacer(),
                Text("sous-titre", style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
        ),
        elevation: 5,
      ),
    );
  }
}
