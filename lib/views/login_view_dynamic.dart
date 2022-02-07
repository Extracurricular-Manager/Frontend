import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontendmobile/main.dart';

class LoginViewDynamic extends StatefulWidget {
  const LoginViewDynamic({Key? key}) : super(key: key);

  @override
  _LoginViewDynamic createState() => _LoginViewDynamic();
}

class _LoginViewDynamic extends State<LoginViewDynamic> {
  LoginUiState globalState = LoginUiState.login;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: userViewBuilder()),
      backgroundColor: Color(0xFF214A1F)
    );
  }

  Widget userViewBuilder(){

    late String pwd;
    late String pwd2;
    late String uname;


    switch (this.globalState){
      case LoginUiState.loading:
        return CircularProgressIndicator(color:Colors.white);
      case LoginUiState.login:
        return Card(
            elevation:5,
            child:Container(
              padding: EdgeInsets.all(20),
              constraints: BoxConstraints(maxWidth: 350),
              child: Wrap(
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [Text("Connexion",
                    style:
                    TextStyle(
                        fontSize: 23 * MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: MyApp.AppColor)),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nom d’utilisateur",
                    ),
                    onChanged: (val) => uname = val,
                  ),
                  TextFormField(
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
                          color:MyApp.AppColor,
                          child: const Text("Connexion"),
                          textColor: Colors.white,
                          onPressed: loginAction,
                        ),
                        MaterialButton(
                          color:Colors.white,
                          child: const Text("Mot de passe oublié"),
                          textColor: MyApp.AppColor,
                          onPressed: forgotAction,
                        ),
                    ],)
                ],),
            ));
      case LoginUiState.setPasswd:
        return Card(
            elevation:5,
            child:Container(
              padding: EdgeInsets.all(20),
              constraints: BoxConstraints(maxWidth: 350),
              child: Wrap(
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [Text("Nouveau mot de passe",
                    style:
                    TextStyle(
                        fontSize: 23 * MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: MyApp.AppColor)),
                  const Text("Votre compte est neuf ou vous avez demandé une réinitialisation de mot de passe. Saisissez-en un nouveau pour poursuivre."),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nouveau mot de passe",
                    ),
                    obscureText: true,
                    onChanged: (val) => uname = val,
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nouveau mot de passe (Confirmation)",
                      ),
                      obscureText: true,
                      onChanged: (val) => pwd = val
                  ),
                  Wrap(
                    spacing: 8,
                    direction: Axis.horizontal,
                    children: [
                      MaterialButton(
                        color:MyApp.AppColor,
                        child: const Text("Poursuivre"),
                        textColor: Colors.white,
                        onPressed: loginAction,
                      ),
                      MaterialButton(
                        color:Colors.white,
                        child: const Text("Annuler"),
                        textColor: MyApp.AppColor,
                        onPressed: () => {setState(() {globalState = LoginUiState.login;})},
                      ),
                    ],)
                ],),
            ));
      case LoginUiState.offline:
        return Container();// TODO: Handle this case.
      case LoginUiState.caching:
        return Container();// TODO: Handle this case.
      case LoginUiState.forgot:
        return Container();
    }

  }

  void loginAction(){

  }

  void forgotAction(){
    setState(() {
      globalState = LoginUiState.setPasswd;
    });

    return null;
  }

  void resetAction(){

  }

}



enum LoginUiState{
  loading,
  login,
  setPasswd,
  forgot,
  offline,
  caching
}