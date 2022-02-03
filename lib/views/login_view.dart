import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF214A1F),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width*0.1 : MediaQuery.of(context).size.width*0.1,
                                        vertical: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height*0.3 : MediaQuery.of(context).size.height*0.15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height*0.4 : MediaQuery.of(context).size.height*0.7,
                    width: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width*0.9 : MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // radius of 10
                        color: Colors.white // green as background color
                        ),
                    child: Form(
                      child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: constraints.biggest.width * 0.1, vertical: constraints.biggest.height * 0.08),
                            child: LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: constraints.biggest.height*0.15,
                                      width: constraints.biggest.width,
                                      child: const Text("Connexion",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Color(0xFF214A1F))),
                                    ),
                                    SizedBox(height: constraints.biggest.height*0.05),
                                    Container(
                                      height: constraints.biggest.height*0.25,
                                      width: constraints.biggest.width,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Nom d’utilisateur",
                                        ),

                                        //controller: ,
                                      ),
                                    ),
                                    SizedBox(height: constraints.biggest.height*0.03),
                                    Container(
                                      height: constraints.biggest.height*0.25,
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
                                    SizedBox(height: constraints.biggest.height*0.05),
                                    Container(
                                      height: constraints.biggest.height*0.20,
                                      width: constraints.biggest.width,
                                      child: OutlinedButton(
                                        child: Text('Connexion',
                                            style: TextStyle(color: Colors.white,fontSize: 10)),
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: const Color(0xFF214A1F),
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
