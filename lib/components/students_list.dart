import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontendmobile/components/recherchelist.dart';
import 'package:frontendmobile/components/search_bar.dart';
import 'package:frontendmobile/data/api_data_classes/child.dart';
import 'package:frontendmobile/data/api_data_classes/presence.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StudentsList extends StatefulWidget {
  final String title;
  final List<ChildData> students;
  final List<Presences> presenceStudent;
  final Color choiceColor;

  const StudentsList({Key? key, required this.title, required this.students, required this.choiceColor, required this.presenceStudent})
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

  void initiliazeMap(List<ChildData> childs, Map<String, bool> mapC) {
    for (var child in childs) {
      mapC[child.name + " " + child.surname] = false;
      for(var i = 0; i<widget.presenceStudent.length;i++){
        if(widget.presenceStudent[i].child.name == child.name
            && widget.presenceStudent[i].child.surname == child.surname){
          mapC[child.name + " " + child.surname] = widget.presenceStudent[i].presence;
        }
      }
    }
  }

  List<Presences> parsePresence(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Presences>((json) => Presences.fromJson(json)).toList();
  }

  Future<List<Presences>> fetchPresence(int id, int service, String name, bool presence, String date, ChildData child) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString("server");
    String key = prefs.getString(url!)!;
    int? idService = prefs.getInt("choiceService");
    // + "?date=" + now.year.toString() + "-"  + now.month.toString() + "-" + now.day.toString()
    final uri = Uri.parse(url + '/api/presence-service/' + idService.toString()
        + "?date=2019-11-03");
    final response = await http.put(
      uri,
      headers: {'authorization': 'Bearer ' + key},
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'serviceId': service,
        'name': name,
        'presence': presence,
        'date': date,
        'child': child,
      }),
    );

    if (response.statusCode == 200) {
      return parsePresence(response.body);
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
          Builder(
            builder: (context) {
              buildSearch();
              allArtists = searchArtistList(query, widget.students);
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: allArtists.length,//widget.students.length,
                itemBuilder: (context, index) {
                  return Card(
                    child:
                    CheckboxListTile(
                      title: Text(
                        allArtists[index].name + " " + allArtists[index].surname,
                        style: const TextStyle(color: Colors.black),
                      ),
                      value: mapChild[allArtists[index].name + " " + allArtists[index].surname],
                      onChanged: (bool? value) {
                        setState(() {
                          /*fetchPresence(widget.presenceStudent[0].id,widget.presenceStudent[0].serviceId,widget.presenceStudent[0].name,
                          !value!,widget.presenceStudent[0].date,allArtists[index]);*/
                          mapChild[allArtists[index].name + " " + allArtists[index].surname] = value!;
                          if (value) {
                            child.add(allArtists[index]);
                          } else {
                            child.remove(allArtists[index]);
                          }
                        });
                      },
                    ),
                  );
                },
              );
            }
          ),
          ElevatedButton(
            onPressed: emptyQueue,
            style: ElevatedButton.styleFrom(
              primary: widget.choiceColor,
            ),
            child: const Text("Validez l'appel"),
          )
        ])
    );
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

  List<ChildData> searchArtistList(
      String query, List<ChildData> artistsTest) {

      final artists = artistsTest.where((artist) {
        String nameSurname = artist.name + " " + artist.surname;
        final nameLower = artist.name.toLowerCase();
        final villeLower = artist.surname.toLowerCase();
        final ville1Lower = nameSurname.toLowerCase();
        final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          villeLower.contains(searchLower) ||
          ville1Lower.contains(searchLower);
    }).toList();
    return artists;
  }
}
