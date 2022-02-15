import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontendmobile/other/providers.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: settings.colorSelected,
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxWidth: 400, maxHeight: 300),
                    height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height*0.4 : MediaQuery.of(context).size.height*0.5,
                    width: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width*0.9 : MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // radius of 10
                        color: Colors.white // green as background color
                        ),
                    child: Form(
                      child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: constraints.biggest.width * 0.1, vertical: constraints.biggest.height * 0.065),
                            child: LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: constraints.biggest.height*0.15,
                                      width: constraints.biggest.width,
                                      child: Text("Connexion",
                                          style: TextStyle(
                                            fontSize: 17 * MediaQuery.of(context).textScaleFactor,
                                              fontWeight: FontWeight.bold,
                                              color: settings.colorSelected)),
                                    ),
                                    SizedBox(height: constraints.biggest.height*0.05),
                                    Container(
                                      height: constraints.biggest.height*0.24,
                                      width: constraints.biggest.width,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Nom d’utilisateur",
                                        ),
                                        //controller: ,
                                      ),
                                    ),
                                    SizedBox(height: constraints.biggest.height*0.06),
                                    Container(
                                      height: constraints.biggest.height*0.24,
                                      width: constraints.biggest.width,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Mot de passe",
                                        ),
                                        obscureText: true,
                                        //controller: ,
                                      ),
                                    ),
                                    SizedBox(height: constraints.biggest.height*0.06),
                                    Container(
                                      height: constraints.biggest.height*0.20,
                                      width: constraints.biggest.width,
                                      child: OutlinedButton(
                                        child: Text('Connexion',
                                            style: TextStyle(color: Colors.white)),
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: settings.colorSelected,
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/home_view');
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }
                            ),
                          );
                        }
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
