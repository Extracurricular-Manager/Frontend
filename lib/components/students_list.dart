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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
/*             leading: IconButton(
              tooltip: 'Leading Icon',
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                // To do
              },
            ), */
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
}
