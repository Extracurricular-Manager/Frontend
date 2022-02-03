import 'package:flutter/material.dart';
import 'package:frontendmobile/components/change_time.dart';

class StudentsBuilder extends StatelessWidget {
  final List<String> students;

  const StudentsBuilder({Key? key, required this.students}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListView.builder(
            itemCount: students.length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(students[index]),
                        subtitle: Row(
                          children: const <Widget>[
                            Icon(Icons.check_circle_outline,
                                color: Color(0xFF045824)),
                            Text(
                              'Présent   ',
                              style: TextStyle(
                                color: Color(0xFF045824),
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
                          showDialog<dynamic>(
                              context: context,
                              builder: (BuildContext context) {
                                return horairePage();
                              })
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
