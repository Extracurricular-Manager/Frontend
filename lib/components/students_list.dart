import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:frontendmobile/components/search_bar.dart';

class StudentsList extends StatefulWidget {
  final String title;
  final List<String> students;
  final Color choiceColor;

  const StudentsList({Key? key, required this.title, required this.students, required this.choiceColor})
      : super(key: key);

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  @override
  void initState() {
    initiliazeMap(widget.students, mapChild);
  }

  Queue child = Queue();
  bool uncheck = false;
  Map<String, bool> mapChild = new Map();

  Future<void> emptyQueue() async {
    while (child.isNotEmpty) {
      String datatoSend = child.first;
      try {
        print(datatoSend);
      } catch (er) {}
      child.removeFirst();
    }
    uncheck = true;
  }

  void initiliazeMap(List<String> childs, Map<String, bool> mapC) {
    for (var child in childs) {
      mapC[child] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
          ],
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(50.0), child: SearchBar()),
        ),
        body: ListView(children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.students.length,
            itemBuilder: (context, index) {
              return Card(
                child: CheckboxListTile(
                  title: Text(
                    widget.students[index],
                    style: const TextStyle(color: Colors.black),
                  ),
                  value: mapChild[widget.students[index]],
                  onChanged: (bool? value) {
                    setState(() {
                      mapChild[widget.students[index]] = value!;
                      if (value) {
                        child.add(widget.students[index]);
                      } else {
                        child.remove(widget.students[index]);
                      }
                      print(child);
                    });
                  },
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: emptyQueue,
            style: ElevatedButton.styleFrom(
              primary: widget.choiceColor,
            ),
            child: const Text("Validez l'appel"),
          )
        ]));
  }
}
