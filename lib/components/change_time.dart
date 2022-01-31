import 'package:flutter/material.dart';

class horairePage extends StatefulWidget {
  HomePage createState() => HomePage();
}

class HomePage extends State<horairePage> {
  late bool morningChildcare = false; // Vrai si enfant présent, faux sinon
  late bool nightChildcare = false;
  late bool canteen = false;

  late bool changeMorningChildcare = false; // Vrai pour avoir la possibilité de changer la valeur
  late bool changeNightChildcare = false;

  TimeOfDay time = TimeOfDay.now();
  TimeOfDay? picked = null;

  TimeOfDay timeNight = TimeOfDay.now();
  TimeOfDay? pickedNight = null;

  Future<Null> selectTime(BuildContext context,bool matin) async {
    if(matin){
      print("Heure du matin");
      picked = await showTimePicker(
          context: context,
          helpText: "Selectionnez votre heure:",
          errorInvalidText: "Entrer une heure valide",
          cancelText: "Annuler",
          hourLabelText: "Heures",
          minuteLabelText: "Minutes",
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
          initialTime: time);
      if (picked != null && matin) {
        setState(() {
          time = picked!;
        });
      }
    }
    else{
      print("Heure du soir");
      pickedNight = await showTimePicker(
          context: context,
          helpText: "Selectionnez votre heure:",
          errorInvalidText: "Entrer une heure valide",
          cancelText: "Annuler",
          hourLabelText: "Heures",
          minuteLabelText: "Minutes",
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
          initialTime: timeNight);
      setState(() {
        timeNight = pickedNight!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding:
            MediaQuery.of(context).orientation == Orientation.portrait ? const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10) : const EdgeInsets.only(left: 50, top: 10, right: 50, bottom: 10),
            child: Container(
              height: (MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 2 :MediaQuery.of(context).size.height),
              child: Column(
                children: [
                  Text("Informations horaire pour l'élève XXX:",
                      style: TextStyle( color: Colors.black, fontSize: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 22 : MediaQuery.of(context).size.height/22)), //
                  SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 30 : MediaQuery.of(context).size.height / 30),
                  garderie("Garderie (Matin)", morningChildcare, changeMorningChildcare, true),
                  garderie("Garderie (Soir)", nightChildcare, changeNightChildcare, false ),
                  garderie("Cantine", true, true,true),
                ],
              ),
            ),
          );
        });
  }

  double taille(double dimension){
    if(MediaQuery.of(context).orientation == Orientation.portrait){
      return MediaQuery.of(context).size.width / dimension;
    }
    else{
      return MediaQuery.of(context).size.height / dimension;
    }
  }

  StatefulBuilder garderie(String message,bool Childcare, bool changeChildcare, bool matin) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          if(message == "Cantine"){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child:
                  Text(message, style: TextStyle(color: Colors.black, fontSize: taille(25)))), //MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 25 : MediaQuery.of(context).size.height / 25
                IconButton(
                  icon: Icon(
                      canteen
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank,
                      size: taille(20)),
                  color: (canteen ? Colors.green : Colors.red),
                  onPressed: () {
                    setState(() {
                      canteen = !canteen;
                    });
                  },
                ),
              ],
            );
          }
          else{
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.2, color: Color(0xFF5E5757)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: taille(3),
                    height: taille(7.5),
                    alignment: Alignment.centerLeft,
                    child: Text(message, style: TextStyle(color: Colors.black,fontSize: taille(25))),
                  ),
                  Container(
                    width: taille(2.91),
                    height: taille(7.5),
                    alignment: Alignment.center,
                    child: Builder(
                      builder: (context) {
                        if(matin){
                          return Builder(
                            builder: (context) {
                              if(time.minute < 10){
                                return Text(
                                    Childcare
                                        ? "Arrivé: " + time.hour.toString() + "H" + "0" + time.minute.toString(): "",
                                    style: TextStyle(color: Colors.black, fontSize: taille(25)));
                              }
                              else{
                                return Text(
                                    Childcare
                                        ? "Arrivé: " + time.hour.toString() + "H" + time.minute.toString(): "",
                                    style: TextStyle(color: Colors.black, fontSize: taille(25)));
                              }
                            }
                          );
                        }
                        else{
                          return Builder(
                            builder: (context) {
                              if(timeNight.minute < 10){
                                return Text(
                                    Childcare
                                        ? "Arrivé: " + timeNight.hour.toString() + "H" + "0" +timeNight.minute.toString(): "",
                                    style: TextStyle(color: Colors.black, fontSize: taille(25)));
                              }
                              else{
                                return Text(
                                    Childcare
                                        ? "Arrivé: " + timeNight.hour.toString() + "H" + timeNight.minute.toString(): "",
                                    style: TextStyle(color: Colors.black, fontSize: taille(25)));
                              }

                            }
                          );
                        }

                      }
                    ),
                  ),
                  Container(
                    height: taille(7.5),
                    child: Row(
                      children: [
                        Builder(
                            builder: (context) {
                              if(Childcare){
                                return IconButton(
                                  icon: Icon(Icons.alarm,
                                      size: taille(20)),
                                  color: (Colors.green),
                                  onPressed: () {
                                    setState(() {
                                      selectTime(context,matin);
                                    });
                                  },
                                );
                              }
                              else{
                                return SizedBox(width: 0);
                              }
                            }
                        ),
                        Builder(builder: (context) {
                          if (!changeChildcare) {
                            return Container(
                              height: taille(7.5),
                              child: IconButton(
                                icon: Icon(
                                    Childcare
                                        ? Icons.check_box_outlined
                                        : Icons.check_box_outline_blank,
                                    size: taille(20)),
                                color:
                                (Childcare ? Colors.green : Colors.red),
                                onPressed: () {
                                  setState(() {
                                    Childcare = !Childcare;
                                    if(matin){
                                      morningChildcare = !morningChildcare;
                                      time = TimeOfDay.now();
                                    }else{
                                      nightChildcare = !nightChildcare;
                                      timeNight = TimeOfDay.now();
                                    }
                                  });
                                },
                              ),
                            );
                          } else {
                            return SizedBox(width: 0);
                          }
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}