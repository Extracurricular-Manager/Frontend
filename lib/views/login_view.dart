import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF214A1F),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(40, 220, 40, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // radius of 10
                        color: Colors.white // green as background color
                        ),
                    child: Form(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text("Connexion",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 2,
                                    fontSize: 40,
                                    color: Color(0xFF214A1F))),
                            const Text("\n"),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Nom d’utilisateur",
                              ),
                              //controller: ,
                            ),
                            const Text(""),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Mot de passe",
                              ),
                              obscureText: true,
                              //controller: ,
                            ),
                            const Text(""),
                            OutlinedButton(
                              child: const Text('Connexion',
                                  style: TextStyle(color: Colors.white)),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: const Color(0xFF214A1F),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/home_view');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
