// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class PageEleve extends StatelessWidget {
  const PageEleve({required String title});

  @override
  Widget build(BuildContext context) {
    //List<String> myList = List.generate(3, (index) => "Theo");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Leading Icon',
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            // To do
          },
        ),
        backgroundColor: const Color(0xFF045824),
        //title: const Text('Page Eleve'),
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0.5),
                  decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white)),
                  child: getAllClasses(context))
            ],
          ),
        ),
/*         bottom: PreferredSize(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0.5),
                decoration: BoxDecoration(
                    color: const Color(0xFF045824),
                    border: Border.all(color: Colors.white)),
                child: const TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'Hint Text',
                      border: OutlineInputBorder(),
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      prefixIcon: Icon(Icons.search)),
                )),
            preferredSize: Size.fromHeight(4.0)), */
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      // leading: const Icon(Icons.people),
                      title: const Text("Théo Giraudet"),
                      subtitle: Row(
                        children: const <Widget>[
                          Icon(Icons.check_circle_outline,
                              color: Color(0xFF045824)),
                          Text(
                            'Présent   ',
                            style: TextStyle(
                              color: Color(0xFF047212),
                            ),
                          ),
                          Icon(Icons.radio_button_unchecked,
                              color: Colors.red), // Pas top
                          Text(
                            'Cantine',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Partie d'Arthur")))
                      },
                      /* onTap: () => Navigator.pushNamed(context, '/eleve',
                            arguments: "ThéoGiraudet") */
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

DropdownButton getAllClasses(BuildContext context) {
  var dropdownValue;
  return DropdownButton<String>(
    value: dropdownValue,
    hint: const Text(
      'Tous les élèves',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    icon: const Icon(Icons.arrow_drop_down),
    onChanged: (String? newValue) {
      /* setState(() {
        dropdownValue = newValue!;
      }); */
    },
    items: <String>['CP', 'CE1', 'CE2', 'CM1', 'CM2']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    iconEnabledColor: Colors.white,
    dropdownColor: Colors.white,
  );
}

//void setState(Null Function() param0) {}

//body search 
/*        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.5),
            decoration: BoxDecoration(
                color: const Color(0xFF045824),
                border: Border.all(color: Colors.white)),
            child: const TextField(
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Hint Text',
                  border: OutlineInputBorder(),
                  hoverColor: Colors.white,
                  focusColor: Colors.white,
                  prefixIcon: Icon(Icons.search)),
            )
            )*/

/*  @override
  Widget build(BuildContext context) {
    //List<String> myList = List.generate(3, (index) => "Theo");

    final student = Provider.of<myList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Profil'),
      ),
      body: ListView.builder(
          itemCount: student.length,
          itemBuilder: (context, index) {
            final ar = student[index];
            return Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.people),
                      title: Text(ar.artistes),
                      subtitle: Column(
                        children: <Widget>[
                          Text(ar.date),
                          Text(ar.edition),
                          Text(ar.annee.toString()),
                          Text(ar.pays),
                          Text(ar.salle),
                          Text(ar.ville),
                          Text(ar.spotify),
                          Text(ar.deezer),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
} */


/* class myList {
  late final String name;
  late final String surname;
  late final int age;
  late final String diet;
  late final String gradeLevel;
  late final String classroom;
} */

/* class myListImpl {
  List<myList> impl () {
      return myList(
        name: (doc.data() as dynamic)['artistes'] ?? "",
        surname: (doc.data() as dynamic)['annee'] ?? "",
        age: (doc.data() as dynamic)['date'] ?? "",
        diet: (doc.data() as dynamic)['deezer'] ?? "",
        gradeLevel: (doc.data() as dynamic)['edition'] ?? "",
        classroom: (doc.data() as dynamic)['id'] ?? "",
      );
    ).toList();
  } */
