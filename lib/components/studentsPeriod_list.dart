import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:frontendmobile/components/recherchelist.dart';
import 'package:frontendmobile/components/search_bar.dart';
import 'package:frontendmobile/data/api_data_classes/child.dart';
import 'package:frontendmobile/data/api_data_classes/period.dart';
import 'package:frontendmobile/data/api_data_classes/presence.dart';

class StudentsPeriodList extends StatefulWidget {
  final String title;
  final List<ChildData> students;
  final List<Period> periodStudent;
  final Color choiceColor;

  const StudentsPeriodList({Key? key, required this.title, required this.students, required this.choiceColor, required this.periodStudent})
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
      for(var i = 0; i<widget.periodStudent.length;i++){
        if(widget.periodStudent[i].child.name == child.name
            && widget.periodStudent[i].child.surname == child.surname){
          mapC[child.name + " " + child.surname] = widget.periodStudent[i];
        }
      }
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
                itemCount: allArtists.length,
                itemBuilder: (context, index) {
                  return Card(
                    child:
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              allArtists[index].name + " " + allArtists[index].surname,
                              style: const TextStyle(color: Colors.black),
                            ),
                            Text(
                              allArtists[index].gradeLevel.level,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children:  [
                            const Text(
                              "Arrivé",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                                onPressed: null,
                                child:
                                  Text(mapChild[allArtists[index].name + " " + allArtists[index].surname] != null ?
                                      mapChild[allArtists[index].name + " " + allArtists[index].surname]!.timeOfArrival[3].toString() + "H"
                                  + mapChild[allArtists[index].name + " " + allArtists[index].surname]!.timeOfArrival[4].toString() :
                                  "Non Arrivé")
                            ),
                            const Text(
                              "Départ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                                onPressed: null,
                                child:
                                Text(mapChild[allArtists[index].name + " " + allArtists[index].surname] != null ?
                                mapChild[allArtists[index].name + " " + allArtists[index].surname]!.timeOfDeparture[3].toString() + "H"
                                    + mapChild[allArtists[index].name + " " + allArtists[index].surname]!.timeOfDeparture[4].toString() :
                                "Non Arrivé")
                            ),
                          ],
                        )
                      ],
                    )
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
