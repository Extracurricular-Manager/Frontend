import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontendmobile/components/change_time.dart';
import 'package:frontendmobile/data/api_data_classes/child.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudentsBuilder extends StatefulWidget {


  const StudentsBuilder({Key? key}) : super(key: key);

  @override
  State<StudentsBuilder> createState() => _StudentsBuilderState();
}

  class _StudentsBuilderState extends State<StudentsBuilder> {

    List<ChildData> parseServices(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<ChildData>((json) => ChildData.fromJson(json)).toList();
    }

    Future<List<ChildData>> fetchServices() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("server");
      String key = prefs.getString(url!)!;
      final response = await http.get(
        Uri.parse(url + '/api/children'),
        headers: {
          'authorization': 'Bearer ' + key,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return parseServices(response.body);
      } else {
        throw Exception('Failed to load album');
      }
    }

    late final Future<List<ChildData>> myServices;

    @override
    void initState() {
      super.initState();
      myServices = fetchServices();
    }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChildData>>(
        future: myServices,
        builder: (context, snapshot){
          print(snapshot.data);
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Center(
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Row(
                              children: [
                                Text(snapshot.data![index].name! + snapshot.data![index].surname!),
                                Text(snapshot.data![index].gradeLevel!.level!),
                              ]
                            ),
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
                });
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
      }
    );
  }
}
