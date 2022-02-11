import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontendmobile/data/api_abstraction/network_utils.dart';
import 'package:frontendmobile/main.dart';

class LoginViewDynamic extends StatefulWidget {
  const LoginViewDynamic({Key? key}) : super(key: key);

  @override
  _LoginViewDynamic createState() => _LoginViewDynamic();
}

class _LoginViewDynamic extends State<LoginViewDynamic> {
  LoginUiState globalState = LoginUiState.loading;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: userViewBuilder()),
        backgroundColor: const Color(0xFF214A1F));
  }

  Widget userViewBuilder() {
    late String pwd;
    late String pwd2;
    late String uname;

    switch (globalState) {
      case LoginUiState.loading:
        loginProcess().then((val) => {});
        return const CircularProgressIndicator(color: Colors.white);
      case LoginUiState.login:
        final TextEditingController IdController = TextEditingController();
        final TextEditingController PwController = TextEditingController();
        return Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Text("Connexion",
                      style: TextStyle(
                          fontSize: 23 * MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.bold,
                          color: MyApp.AppColor)),
                  TextFormField(
                    controller: IdController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nom d’utilisateur",
                    ),
                    onChanged: (val) => uname = val,
                  ),
                  TextFormField(
                      controller: PwController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Mot de passe",
                      ),
                      obscureText: true,
                      onChanged: (val) => pwd = val
                      //controller: ,
                      ),
                  Wrap(
                    spacing: 8,
                    direction: Axis.horizontal,
                    children: [
                      MaterialButton(
                        color: MyApp.AppColor,
                        child: const Text("Connexion"),
                        textColor: Colors.white,
                        onPressed: loginAction,
                      ),
                      MaterialButton(
                        color: Colors.white,
                        child: const Text("Mot de passe oublié"),
                        textColor: MyApp.AppColor,
                        onPressed: () => {changeState(LoginUiState.forgot)},
                      ),
                    ],
                  )
                ],
              ),
            ));
      case LoginUiState.setPasswd:
        return Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Text("Nouveau mot de passe",
                      style: TextStyle(
                          fontSize: 23 * MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.bold,
                          color: MyApp.AppColor)),
                  const Text(
                      "Votre compte est neuf ou vous avez demandé une réinitialisation de mot de passe. Saisissez-en un nouveau pour poursuivre."),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nouveau mot de passe",
                    ),
                    obscureText: true,
                    initialValue: "",
                    onChanged: (val) => uname = val,
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nouveau mot de passe (Confirmation)",
                      ),
                      obscureText: true,
                      initialValue: "",
                      onChanged: (val) => pwd = val),
                  Wrap(
                    spacing: 8,
                    direction: Axis.horizontal,
                    children: [
                      MaterialButton(
                        color: MyApp.AppColor,
                        child: const Text("Poursuivre"),
                        textColor: Colors.white,
                        onPressed: loginAction,
                      ),
                      MaterialButton(
                        color: Colors.white,
                        child: const Text("Annuler"),
                        textColor: MyApp.AppColor,
                        onPressed: () => {
                          setState(() {
                            changeState(LoginUiState.login);
                          })
                        },
                      ),
                    ],
                  )
                ],
              ),
            ));
      case LoginUiState.offline:
        return Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off,
              size: 70,
              color: Colors.white,
            ),
            const Text(
              "Le service semble être inaccessible",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 50,
            ),
            Wrap(
              spacing: 10,
              children: [
                MaterialButton(
                  onPressed: () =>
                      Navigator.popAndPushNamed(context, "/login_view"),
                  color: Colors.white,
                  textColor: MyApp.AppColor,
                  child: const Text("Réessayer"),
                ),
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  color: Colors.white,
                  textColor: MyApp.AppColor,
                  child: const Text("Retour"),
                )
              ],
            )
          ],
        );
      case LoginUiState.caching:
        return Container(); // TODO: Handle this case.
      case LoginUiState.forgot:
        return Container(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: constraints.biggest.height * 0.15,
                width: constraints.biggest.width,
                child: Text("Mot de passe oublié ?",
                    style: TextStyle(
                        fontSize: 17 * MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF214A1F))),
              ),
              const Text(
                "Si vous validez la sélection, une demande de modificaiton de mot de passe sera envoyée.",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: constraints.biggest.height * 0.05),
              Container(
                height: constraints.biggest.height * 0.24,
                width: constraints.biggest.width,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nom d’utilisateur",
                  ),
                  //controller: ,
                ),
              ),
              SizedBox(height: constraints.biggest.height * 0.06),
              SizedBox(
                  height: constraints.biggest.height * 0.24,
                  width: constraints.biggest.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Wrap(
                        spacing: 8,
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        children: [
                          MaterialButton(
                            color: Colors.green,
                            child: const Text("Poursuivre"),
                            textColor: Colors.white,
                            onPressed: () => {},
                          ),
                          MaterialButton(
                              color: Colors.red,
                              child: const Text("Annuler"),
                              textColor: Colors.white,
                              onPressed: () => {
                                    Navigator.pop(context),
                                  })
                        ],
                      ),
                    ],
                  ))
            ],
          );
        }));
    }
  }

  void loginAction() {
    Navigator.popAndPushNamed(context, '/home_view');
    //changeState(LoginUiState.login);

    //postop avec 2 elemennt pour id et mdp après
  }

  void forgotAction() {
    changeState(LoginUiState.setPasswd);
  }

  void resetAction() {}

  void pwdResetAction() {}

  Future<void> loginProcess() async {
    if (await NetworkUtils.getConnectivity() == NetworkStatus.ok) {
      changeState(LoginUiState.login);
    } else {
      changeState(LoginUiState.offline);
    }
  }

  void changeState(LoginUiState newState) {
    setState(() {
      globalState = newState;
    });
  }
}

enum LoginUiState { loading, login, setPasswd, forgot, offline, caching }
