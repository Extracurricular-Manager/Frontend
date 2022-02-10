import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String path;
  final IconData iconName;

  const HomeTile({
    Key? key,
    required this.title,
    required this.path,
    required this.subtitle,
    required this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var elev = 5.0;
    return Card(
      elevation: elev,
      child: Container(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, path);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  iconName,
                  size: 30,
                ),
                Text(title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(subtitle, style: const TextStyle(color: Colors.grey))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
