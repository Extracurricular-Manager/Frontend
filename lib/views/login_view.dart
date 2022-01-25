import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.fromLTRB(40, 100, 40, 100),
        color: const Color(0xFF214A1F),
        child: ListView(
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
                              height: 2, fontSize: 40, color: Color(0xFF214A1F))),
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), // radius of 10
                          color: const Color(0xFF214A1F),
                        ),
                        child: const TextButton(
                          onPressed: null,
                          child: Text('Connexion',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
