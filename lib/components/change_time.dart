import 'package:flutter/material.dart';

class dumbDataClass {
  Map<String, TimeOfDay> mop = {};

  TimeOfDay? getItem(String id){
    print('Lecture de '+id);
    return mop[id];
  }

  void setItem(String id, TimeOfDay? value){
    print('Écriture de '+id +' : ' + value.toString());
    if (value !=null){
      mop[id] = value;
    }
    else{
      print("Pas de valeur transmise, suppression de "+id);
      removeItem(id);
    }
  }

  void removeItem(String id){
    print('Suppression de '+id);
    mop.remove(id);
  }
}

class horairePage extends StatefulWidget {
  HomePage createState() => HomePage();
}

class HomePage extends State<horairePage> {
  final Map<String, bool> someMap = {};
  final dumbDataClass timeDumb = dumbDataClass();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return
            AlertDialog(
              title: const Text('Élève XXX'),
              titlePadding: EdgeInsets.fromLTRB(10,10,10,0),
              content: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ListView.builder(
                    shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return serviceItem("Gardener(Soir)",true,index.toString());
                        },
                      ).build(context),
              ),
              contentPadding: EdgeInsets.fromLTRB(10,10,10,10),
            );
        });
  }

  StatefulBuilder serviceItem(String serviceName,bool settableTime, String id){
    return StatefulBuilder(
      builder:(BuildContext context, StateSetter setState) {
        return CheckboxListTile(title:titleAndTimeSelector(Text(serviceName), settableTime, id),value: someMap[id] ?? false,contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0) ,activeColor: Color(0xFF214A1F), onChanged: (bool? value) {
          setState(() {
            if (value!){
              timeDumb.setItem(id, TimeOfDay.now());
            } else {
              timeDumb.removeItem(id);
            }
            someMap[id]=value;
        });});
      }
    );
  }

  StatefulBuilder titleAndTimeSelector(Widget text,bool showClock, String id){
      return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
        var timeData = timeDumb.getItem(id);
        timePickerButton cb = timePickerButton(TimeOfDay.now(), (value){timeDumb.setItem(id, value);});
        return showClock && timeData!= null ? Row(children: [text, Spacer(), cb.clockButton()]) : text;
      }
    );
  }
  }

  StatefulBuilder timeCalculator(time) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Text(time.hour.toString() + "h" + (time.minute < 10 ? "0" : "") +
          time.minute.toString(), style: const TextStyle(color:Colors.white),);
    });
  }

class timePickerButton{
  late TimeOfDay stored;
  late Function onUpdate;
  timePickerButton(TimeOfDay time,this.onUpdate){
    stored=time;
  }

  StatefulBuilder clockButton(){
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      print(MediaQuery.of(context).size.width*0.18);
      print(MediaQuery.of(context).size.width > 70);
          return Container(
            width: MediaQuery.of(context).size.width*0.18 > 60 ? MediaQuery.of(context).size.width*0.18 : MediaQuery.of(context).size.width*0.1,
            child: MaterialButton(color:Color(0xFF214A1F), padding: MediaQuery.of(context).size.width*0.18 > 60 ? EdgeInsets.fromLTRB(0, 0, 0, 0) : EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.025, 0, MediaQuery.of(context).size.width*0.025, 0),
                    child: Row(children:[Icon(Icons.edit,color:Colors.white, size: 14), MediaQuery.of(context).size.width*0.18 > 60 ? timeCalculator(stored) : SizedBox(width: 0)]), onPressed: () {
                  timeSelector(context, stored).then((value) => {
                    if (value != null){
                      setState((){
                        onUpdate(value);
                        stored = value;})
                    }}
                  );
                }
                )

          );
        }
      );
  }
  Future<TimeOfDay?> timeSelector(BuildContext context, TimeOfDay? initialTime)  {
    var initTime = initialTime ?? TimeOfDay.now();
    return showTimePicker(
        context: context,
        helpText: "Selectionnez une heure",
        errorInvalidText: "Entrez une heure valide",
        cancelText: "Annuler",
        hourLabelText: "Heures",
        minuteLabelText: "Minutes",
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );},
        initialTime: initTime);
  }
}
