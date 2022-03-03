import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontendmobile/data/api_abstraction/network_utils.dart';
import 'package:frontendmobile/data/api_data_classes/token.dart';
import 'package:frontendmobile/other/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;


class LoginViewDynamic extends ConsumerStatefulWidget {

  const LoginViewDynamic({Key? key}) : super(key: key);

  @override
  _LoginViewDynamic createState() => _LoginViewDynamic();
}

class _LoginViewDynamic extends ConsumerState<LoginViewDynamic> {
  LoginUiState globalState = LoginUiState.loading;

  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  bool visible = true;

  fetchAlbum(String name, String mdp) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? url = prefs.getString("server");
     var params = {
       "username": name,
       "password": mdp,
       "rememberMe": true
     };
     final jsonString = json.encode(params);
     final uri = Uri.parse(url! + '/api/authenticate');
     final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
     final response = await http.post(uri, headers: headers, body: jsonString);
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        errorConnect = false;
        String cle = response.body;
        String finalcle = cle.substring(13,cle.length-2);
        prefs.setString(url, finalcle);
        SignUp = true;
        loginAction();
        return idtoken.fromJson(jsonDecode(response.body));
      }
      else{
        setState(() {
          errorConnect = true;
        });

      }
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: settings.colorSelected,
        body: Center(
            child:
             userViewBuilder(settings.colorSelected),
        )
    );
  }

  String error = "";
  final identificationConnect = TextEditingController();
  final passwordConnect = TextEditingController();
  bool SignUp = false;
  bool errorConnect = false;

  @override
  void dispose() {
    identificationConnect.dispose();
    passwordConnect.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      error = '';
      identificationConnect.text = '';
      passwordConnect.text = '';
      SignUp = false;
    });
  }

  Widget userViewBuilder(Color colorSelected) {

    switch (globalState) {
      case LoginUiState.loading:
        loginProcess().then((val) => {});
        return const CircularProgressIndicator(color: Colors.white);
      case LoginUiState.login:
       // final TextEditingController IdController = TextEditingController();
       // final TextEditingController PwController = TextEditingController();
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
                          color: colorSelected)),
                  TextFormField(
                    //controller: IdController,
                    controller: identificationConnect,
                    focusNode: myFocusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: colorSelected, width: 2.0),
                      ),
                      labelText: "Nom d’utilisateur",
                      labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? colorSelected : Colors.grey,
                      )
                    ),
                  ),
                  TextFormField(
                     // controller: PwController,
                      controller: passwordConnect,
                      focusNode: myFocusNode1,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(icon: Icon(visible ? Icons.visibility : Icons.visibility_off, color: colorSelected),
                            onPressed: () {
                              setState(() {
                                visible=!visible;
                              });
                            },),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: colorSelected, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Mot de passe",
                        labelStyle: TextStyle(
                          color: myFocusNode1.hasFocus ? colorSelected : Colors.grey,
                        )
                      ),
                      obscureText: visible,
                    //controller: ,
                  ),
                  errorConnect ? Text("L’adresse e-mail ou votre mot de passe que vous avez saisie n’est pas correcte."):SizedBox(width: 0),
                  Wrap(
                    spacing: 8,
                    direction: Axis.horizontal,
                    children: [
                      MaterialButton(
                        color: colorSelected,
                        child: const Text("Connexion"),
                        textColor: Colors.white,
                        onPressed: () => {
                          //getKey(fetchAlbum(identificationConnect.value.text, passwordConnect.value.text)),
                          fetchAlbum(identificationConnect.value.text, passwordConnect.value.text),
                        }
                      ),
                      MaterialButton(
                        color: Colors.white,
                        child: const Text("Mot de passe oublié"),
                        textColor: colorSelected,
                        onPressed: () => {changeState(LoginUiState.forgot),toggleView()},
                      ),
                      MaterialButton(
                        color: Colors.white,
                        child: const Text("Changer d'école"),
                        textColor: colorSelected,
                        onPressed: () => {Navigator.popAndPushNamed(context, '/choice')},
                      ),
                      MaterialButton(
                        color: colorSelected,
                        child: const Text("Ajouter mon école"),
                        textColor: Colors.white,
                        onPressed: () => {Navigator.popAndPushNamed(context, '/addServer')},
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
                          color: colorSelected)),
                  const Text(
                      "Votre compte est neuf ou vous avez demandé une réinitialisation de mot de passe. Saisissez-en un nouveau pour poursuivre."),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nouveau mot de passe",
                    ),
                    obscureText: true,
                    initialValue: "",
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nouveau mot de passe (Confirmation)",
                      ),
                      obscureText: true,
                      initialValue: "",
                  ),
                  Wrap(
                    spacing: 8,
                    direction: Axis.horizontal,
                    children: [
                      MaterialButton(
                        color: colorSelected,
                        child: const Text("Poursuivre"),
                        textColor: Colors.white,
                        onPressed: loginAction,
                      ),
                      MaterialButton(
                        color: Colors.white,
                        child: const Text("Annuler"),
                        textColor: colorSelected,
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
                  textColor: colorSelected,
                  child: const Text("Réessayer"),
                ),
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  color: Colors.white,
                  textColor: colorSelected,
                  child: const Text("Retour"),
                )
              ],
            )
          ],
        );
      case LoginUiState.caching:
        return Container();
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
                            color: colorSelected)),
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
    if(SignUp){
      toggleView();
      Navigator.popAndPushNamed(context, '/home_view');
    }
    else{
      print("CONNEXION IMPOSSIBLE");
    }
  }

  void forgotAction() {
    changeState(LoginUiState.setPasswd);
  }

  void change(){
    SignUp = true;
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