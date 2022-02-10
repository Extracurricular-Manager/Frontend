import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LargeHomeTile extends StatelessWidget {
  final String onTapPath;
  final String title;
  final String subtitle;
  final IconData iconName;

  const LargeHomeTile(
      {Key? key,
      required this.onTapPath,
      required this.iconName,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
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
              children: [
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
        elevation: 5,
      ),
    );
  }
}
