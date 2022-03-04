import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontendmobile/components/recherchelist.dart';
import 'package:frontendmobile/data/api_data_classes/child.dart';
import 'package:frontendmobile/data/api_data_classes/period.dart';
import 'package:frontendmobile/data/api_data_classes/presence.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StudentsPeriodList extends StatefulWidget {
  final String title;
  final List<ChildData> students;
  final List<Period> periodStudent;
  final Color choiceColor;

  const StudentsPeriodList(
      {Key? key,
      required this.title,
      required this.students,
      required this.choiceColor,
      required this.periodStudent})
      : super(key: key);

  @override
  State<StudentsPeriodList> createState() => _StudentsPeriodListState();
}

class _StudentsPeriodListState extends State<StudentsPeriodList> {
  @override
  void initState() {
    initiliazeMap(widget.students, mapChild);
  }

  Queue child = Queue();
  bool uncheck = false;
  Map<String, Period> mapChild = new Map();

  String query = '';
  List<ChildData> allArtists = [];

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

  void initiliazeMap(List<ChildData> childs, Map<String, Period> mapC) {
    for (var child in childs) {
      for (var i = 0; i < widget.periodStudent.length; i++) {
        if (widget.periodStudent[i].child.name == child.name &&
            widget.periodStudent[i].child.surname == child.surname) {
          mapC[child.name! + " " + child.surname!] = widget.periodStudent[i];
        }
      }
    }
  }

  List<Period> parsePeriod(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Period>((json) => Period.fromJson(json)).toList();
  }

  Future<List<Period>> fetchPeriod(
      /*int id, String timeOfArrival, String timeOfDeparture, String timeOfStartBilling,*/
      String name,
      String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString("server");
    String key = prefs.getString(url!)!;
    int? idService = prefs.getInt("choiceService");
    ChildData mychild = new ChildData();
    for (var child in widget.students) {
      if (child.name == name && child.surname == username) {
        mychild = child;
      }
    }
    // + "?date=" + now.year.toString() + "-"  + now.month.toString() + "-" + now.day.toString()
    final uri = Uri.parse(url +
        '/api/period-service/' +
        idService.toString() +
        "?date=2019-11-03");
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'authorization': 'Bearer ' + key
    };
    final response = await http.put(
      uri,
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'id': 3,
        'serviceId': 0,
        'timeOfArrival': [2019, 11, 3, 6, 30],
        'timeOfDeparture': [2019, 11, 3, 11, 30],
        'timeOfStartBilling': [2019, 11, 3, 6, 30],
        'child': mychild,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return parsePeriod(response.body);
    } else {
      throw Exception('Failed to load album');
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
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0), child: buildSearch()),
        ),
        body: ListView(children: [
          Builder(builder: (context) {
            buildSearch();
            allArtists = searchArtistList(query, widget.students);
            return ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: allArtists.length,
              itemBuilder: (context, index) {
                return Card(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          allArtists[index].name! +
                              " " +
                              allArtists[index].surname!,
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                          allArtists[index].gradeLevel!.level!,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Arrivé",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                            onPressed: null,
                            child: Text(mapChild[allArtists[index].name! +
                                        " " +
                                        allArtists[index].surname!] !=
                                    null
                                ? mapChild[allArtists[index].name! +
                                            " " +
                                            allArtists[index].surname!]!
                                        .timeOfArrival[3]
                                        .toString() +
                                    "H" +
                                    mapChild[allArtists[index].name! +
                                            " " +
                                            allArtists[index].surname!]!
                                        .timeOfArrival[4]
                                        .toString()
                                : "Non Arrivé")),
                        const Text(
                          "Départ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              fetchPeriod(allArtists[index].name!,
                                  allArtists[index].surname!);
                            },
                            child: Text(mapChild[allArtists[index].name! +
                                        " " +
                                        allArtists[index].surname!] !=
                                    null
                                ? mapChild[allArtists[index].name! +
                                            " " +
                                            allArtists[index].surname!]!
                                        .timeOfDeparture[3]
                                        .toString() +
                                    "H" +
                                    mapChild[allArtists[index].name! +
                                            " " +
                                            allArtists[index].surname!]!
                                        .timeOfDeparture[4]
                                        .toString()
                                : "Non Arrivé")),
                      ],
                    )
                  ],
                ));
              },
            );
          }),
          ElevatedButton(
            onPressed: emptyQueue,
            style: ElevatedButton.styleFrom(
              primary: widget.choiceColor,
            ),
            child: const Text("Validez l'appel"),
          )
        ]));
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Prénom ou Nom',
        onChanged: searchArtist,
      );

  void searchArtist(String query) {
    setState(() {
      this.query = query;
    });
  }

  List<ChildData> searchArtistList(String query, List<ChildData> artistsTest) {
    final artists = artistsTest.where((artist) {
      String nameSurname = artist.name! + " " + artist.surname!;
      final nameLower = artist.name!.toLowerCase();
      final villeLower = artist.surname!.toLowerCase();
      final ville1Lower = nameSurname.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          villeLower.contains(searchLower) ||
          ville1Lower.contains(searchLower);
    }).toList();
    return artists;
  }
}
