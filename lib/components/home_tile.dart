import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String path;
  final IconData iconName;
  final int idService;
  final String nameService;

  const HomeTile({
    Key? key,
    required this.title,
    required this.path,
    required this.idService,
    required this.nameService,
    required this.subtitle,
    required this.iconName,
  }) : super(key: key);

  choiceService(int idService) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("choiceService", idService);
  }

  getNameService(String nameServ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("nameService", nameServ);
  }

  @override
  Widget build(BuildContext context) {
    print(title);
    print(path);
    print(idService);
    print(nameService);
    print(subtitle);
    print(iconName);
    var elev = 5.0;
    return Card(
      elevation: elev,
      child: Container(
        child: InkWell(
          onTap: () {
            choiceService(this.idService);
            getNameService(this.nameService);
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
