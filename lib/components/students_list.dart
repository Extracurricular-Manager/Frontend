import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontendmobile/components/search_bar.dart';

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
      body: ListView(
        children: [
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
        ],
      ),
    );
  }
}
