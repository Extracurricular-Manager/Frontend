import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontendmobile/components/change_time.dart';
import 'package:frontendmobile/components/recherchelist.dart';
import 'package:frontendmobile/components/search_bar.dart';
import 'package:frontendmobile/components/students_list_view_builder.dart';
import 'package:frontendmobile/components/students_list_view_builder.dart';
import 'package:frontendmobile/data/api_data_classes/child.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class StudentView extends StatefulWidget {
  const StudentView({Key? key}) : super(key: key);

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {

  String query = '';
  List<ChildData> allArtists = [];

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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          //title: const Text('Page Eleve'),
          title: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 0.5),
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white)),
                    child: getAllClasses(context))
              ],
            ),
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.0), child: buildSearch()),
        ),
        body: FutureBuilder<List<ChildData>>(
            future: myServices,
            builder: (context, snapshot){
              if(snapshot.hasData){
                buildSearch();
                allArtists = searchArtistList(query, snapshot.data!);
                return ListView.builder(
                    itemCount: allArtists.length,
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
                                      Text(allArtists[index].name! + " " + allArtists[index].surname! + " "),
                                      Text(allArtists[index].gradeLevel!.level!),
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
        )
    );
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Prénom ou Nom ou Classe',
    onChanged: searchArtist,
  );

  void searchArtist(String query) {
    setState(() {
      this.query = query;
    });
  }

  List<ChildData> searchArtistList(
      String query, List<ChildData> artistsTest) {

    final artists = artistsTest.where((artist) {
      String nameSurname = artist.name! + " " + artist.surname!;
      final nameLower = artist.name!.toLowerCase();
      final villeLower = artist.surname!.toLowerCase();
      final ville1Lower = nameSurname.toLowerCase();
      final ville2 = artist.gradeLevel!.level!.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          villeLower.contains(searchLower) ||
          ville1Lower.contains(searchLower) ||
          ville2.contains(searchLower);
    }).toList();
    return artists;
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
}
