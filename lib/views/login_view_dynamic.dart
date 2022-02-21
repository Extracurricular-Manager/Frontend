import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontendmobile/data/api_abstraction/network_utils.dart';
import 'package:frontendmobile/other/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewDynamic extends ConsumerStatefulWidget {
  const LoginViewDynamic({Key? key}) : super(key: key);

  @override
  _LoginViewDynamic createState() => _LoginViewDynamic();
}

class _LoginViewDynamic extends ConsumerState<LoginViewDynamic> {
  LoginUiState globalState = LoginUiState.loading;

  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  bool visible = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: settings.colorSelected,
        body: Center(child: userViewBuilder(settings.colorSelected)));
  }

  Widget userViewBuilder(Color colorSelected) {
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
                          color: colorSelected)),
                  TextFormField(
                    controller: IdController,
                    focusNode: myFocusNode,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: colorSelected, width: 2.0),
                        ),
                        labelText: "Nom d’utilisateur",
                        labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? colorSelected
                              : Colors.grey,
                        )),
                    onChanged: (val) => uname = val,
                  ),
                  TextFormField(
                      controller: PwController,
                      focusNode: myFocusNode1,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                                visible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: colorSelected),
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: colorSelected, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Mot de passe",
                          labelStyle: TextStyle(
                            color: myFocusNode1.hasFocus
                                ? colorSelected
                                : Colors.grey,
                          )),
                      obscureText: visible,
                      onChanged: (val) => pwd = val
                      //controller: ,
                      ),
                  Wrap(
                    spacing: 8,
                    direction: Axis.horizontal,
                    children: [
                      MaterialButton(
                        color: colorSelected,
                        child: const Text("Connexion"),
                        textColor: Colors.white,
                        onPressed: loginAction,
                      ),
                      MaterialButton(
                        color: Colors.white,
                        child: const Text("Mot de passe oublié"),
                        textColor: colorSelected,
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
        return Container(); // TODO: Handle this case.
      case LoginUiState.forgot:
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    constraints:
                        const BoxConstraints(maxWidth: 400, maxHeight: 300),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // radius of 10
                        color: Colors.white // green as background color
                        ),
                    child: Form(
                      child: LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Card(
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: constraints.biggest.width * 0.1,
                                  vertical: constraints.biggest.height * 0.065),
                              child: LayoutBuilder(builder:
                                  (BuildContext context,
                                      BoxConstraints constraints) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: constraints.biggest.height * 0.15,
                                      width: constraints.biggest.width,
                                      child: Text("Mot de passe oublié ?",
                                          style: TextStyle(
                                              fontSize: 17 *
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF214A1F))),
                                    ),
                                    const Text(
                                      "Si vous validez la sélection, une demande de modificaiton de mot de passe sera envoyée.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                        height:
                                            constraints.biggest.height * 0.05),
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
                                    SizedBox(
                                        height:
                                            constraints.biggest.height * 0.06),
                                    SizedBox(
                                        height:
                                            constraints.biggest.height * 0.24,
                                        width: constraints.biggest.width,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Wrap(
                                              spacing: 8,
                                              direction: Axis.horizontal,
                                              alignment: WrapAlignment.center,
                                              children: [
                                                MaterialButton(
                                                  color: Colors.green,
                                                  child:
                                                      const Text("Poursuivre"),
                                                  textColor: Colors.white,
                                                  onPressed: () => {},
                                                ),
                                                MaterialButton(
                                                  color: Colors.red,
                                                  child: const Text("Annuler"),
                                                  textColor: Colors.white,
                                                  onPressed: () => {
                                                    setState(() {
                                                      changeState(
                                                          LoginUiState.login);
                                                    })
                                                  },
                                                )
                                              ],
                                            ),
                                          ],
                                        ))
                                  ],
                                );
                              }),
                            ));
                      }),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
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
