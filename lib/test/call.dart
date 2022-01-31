import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontendmobile/data/child.dart';
import 'package:http/http.dart' as http;

//Queue<Child> childCalled = Queue();
Queue<String> childCalled = Queue();

class Call extends StatefulWidget {
  Call({
    Key? key,
  }) : super(key: key);
  List<String> childs = [
    "Erreur d'affichage",
    "Arthur",
    "Curtis",
    "Guillaume",
    "Sara"
  ];

  @override
  _CallState createState() => _CallState();
}

String baseUrl = "/api";

class _CallState extends State<Call> {
  final url = baseUrl;
  Map<String, bool> values = {};

  bool _isChecked = false;

  Future<void> emptyQueue() async {
    while (childCalled.isNotEmpty) {
      String datatoSend = childCalled.first;
      try {
        // ignore: unused_local_variable
        //final response = await http.post(Uri.parse(url), body: datatoSend);
        // ignore: avoid_print
        print(datatoSend);
      } catch (er) {}
      childCalled.removeFirst();
    }
  }

  // void postData(String datatoSend) async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            ListView.builder(
                itemCount: widget.childs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: CheckboxListTile(
                      title: Text(
                        widget.childs[index],
                        style: const TextStyle(color: Colors.black),
                      ),
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                          childCalled.add(widget.childs[index]);
                        });
                      },
                    ),
                  );
                }),
            ElevatedButton(
              onPressed: emptyQueue,
              child: const Text("Validez l'appel"),
            )
          ],
        ),
      ),
    );
  }
}

Map<String, bool> initiliazeMap(List childs) {
  Map<String, bool> a = {};
  for (var child in childs) {
    a.addEntries([MapEntry(child, false)]);
  }
  return a;
}


/* 
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentsList extends StatefulWidget {
   final String title;
  final List<String> students;

  const StudentsList({Key? key, required this.title, required this.students})
      : super(key: key);

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  bool _isChecked = false;
  Queue child = Queue();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xFF214A1F),
            title: Text(widget.title),
            shadowColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                        tooltip: 'Add new user',
                        onPressed: null,
                      ),
                    )),
              )
            ]),
        body: Stack(children: [
          ListView.builder(
            itemCount: widget.students.length,
            itemBuilder: (context, index) {
              return Card(
                child: CheckboxListTile(
                  title: Text(
                    widget.students[index],
                    style: const TextStyle(color: Colors.black),
                  ),
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                      child.add(widget.students[index]);
                    });
                  },
                ),
              );
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle, color: Color(0xFF214A1F)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // radius of 10
                  color: Colors.white,
                ),
                child: const TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                )),
          ),
        ]));
  }
} */
