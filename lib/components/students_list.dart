import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentsList extends StatelessWidget {
  final String title;
  final List<String> students;

  const StudentsList({Key? key, required this.title, required this.students})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool value = false;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Leading Icon',
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            // To do
          },
        ),
        backgroundColor: const Color(0xFF214A1F),
        title: Column(
          children: [
            Text(title),
            /*Container(
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
                )),*/
          ],
        ),
        actions: const <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_add,
              color: Colors.white,
            ),
            tooltip: 'Add new user',
            onPressed: null,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
              title: Text(
                students[index],
                style: const TextStyle(color: Colors.black),
              ),
              value: value,
              onChanged:  null
          );
        },
      ),
    );
  }
}