import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:frontendmobile/components/search_bar.dart';

class TestView extends StatefulWidget {
  final String title;
  final List<String> students;

  const TestView({Key? key, required this.title, required this.students})
      : super(key: key);

  @override
  State<TestView> createState() => _TestState();
}

class _TestState extends State<TestView> {
  //final mapChild = initiliazeMap2(students,mapChild);
  @override
  void initState() {
    initiliazeMap(widget.students, mapChild);
  }

  /*   final List<String> students = [
    "Erreur d'affichage",
    "Arthur",
    "Curtis",
    "Guillaume",
    "Sara"
  ];  */

/*   Map<String, bool> mapChild = {
    "Erreur d'affichage": false,
    "Arthur": false,
    "Curtis": false,
    "Guillaume": false,
    "Sara": false
  }; */

  //
  Queue child = Queue();
  bool Uncheck = false;
  Map<String, bool> mapChild = new Map();

  Future<void> emptyQueue() async {
    while (child.isNotEmpty) {
      String datatoSend = child.first;
      try {
        //final response = await http.post(Uri.parse(url), body: datatoSend);
        print(datatoSend);
      } catch (er) {}
      child.removeFirst();
    }
    Uncheck = true;
  }

  void initiliazeMap(List<String> childs, Map<String, bool> mapC) {
    for (var child in childs) {
      mapC[child] = false;
    }
  }

/* getUl(){
initiliazeMap3(students, mapChild);
} */

  @override
  Widget build(BuildContext context) {
    //   print("Init " + mapChild.toString());
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
                    /* mapChild.keys.firstWhere(
                        (k) => mapChild[k] == widget.students[index],
                        orElse: () => "null") */
                    widget.students[index],
                    style: const TextStyle(color: Colors.black),
                  ),
                  value: mapChild[widget.students[index]],
                  onChanged: (bool? value) {
                    setState(() {
                      mapChild[widget.students[index]] = value!;
                      //  print(Uncheck);
                      if (value) {
                        child.add(widget.students[index]);
                      } else {
                        child.remove(widget.students[index]);
                      }
                      /*   print(Uncheck);
                      if (Uncheck == true) {
                        //reset checkbox : not working ?
                        // print("im in");
                        // mapChild.updateAll((key, value) => false);
                        /* for (var element in mapChild.values) {
                          print("a");
                          element = false;
                        } */
                        Uncheck = false;
                      } */

                      print(child);
                      // print(mapChild);
                    });
                  },
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: emptyQueue,
            child: const Text("Validez l'appel"),
          )
        ]));
  }

/*     Future<void> emptyQueue(Queue childCalled) async {
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
  } */

/*   void ListoMap(List a, Map b) {
    //b.forEach((key, value) { })
    //  a.stream().;
    for (var i in a) {
      b.addEntries([MapEntry(i, false)]);
    }
  }

  Map<String, bool> initiliazeMap(List childs) {
    Map<String, bool> a = {};
    for (var child in childs) {
      a.addEntries([MapEntry(child, false)]);
    }
    return a;
  } */

}
