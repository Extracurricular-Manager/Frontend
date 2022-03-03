import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontendmobile/components/studentsPeriod_list.dart';
import 'package:frontendmobile/components/students_list.dart';
import 'package:frontendmobile/data/api_data_classes/child.dart';
import 'package:frontendmobile/data/api_data_classes/period.dart';
import 'package:frontendmobile/other/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DayNurseryView extends ConsumerStatefulWidget {
  const DayNurseryView({Key? key}) : super(key: key);

  @override
  _DayNurseryViewState createState() => _DayNurseryViewState();
}

class _DayNurseryViewState extends ConsumerState<DayNurseryView> {

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
    if (response.statusCode == 200) {
      return parseServices(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  List<Period> parsePresence(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ChildData>((json) => Period.fromJson(json)).toList();
  }

  Future<List<Period>> fetchPeriod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString("server");
    String key = prefs.getString(url!)!;
    int? idService = prefs.getInt("choiceService");
    final uri = Uri.parse(url + '/api/period-service/' + idService.toString()); // + "?date=" + now.year.toString() + "-"  + now.month.toString() + "-" + now.day.toString()
    print(uri.toString());
    final response = await http.get(
      uri,
      headers: {'authorization': 'Bearer ' + key},
    );
    if (response.statusCode == 200) {
      return parsePresence(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  late final Future<List<ChildData>> childrens;
  late final Future<List<Period>> periods;
  late final Future<String> mytitle;

  @override
  void initState() {
    super.initState();
    childrens = fetchServices();
    periods = fetchPeriod();
    mytitle = getName();
  }

  Future<String> getName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("nameService")!;
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return FutureBuilder<List<ChildData>>(
        future: childrens,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return FutureBuilder<List<Period>>(
                future: periods,
                builder: (context, snapshot1) {
                  return FutureBuilder<String>(
                      future: mytitle,
                      builder: (context, snapshot2) {
                        if(snapshot2.hasData){
                          return StudentsPeriodList(
                            title: snapshot2.data!,
                            students: snapshot.data!,
                            choiceColor: settings.colorSelected,
                            periodStudent: snapshot1.data == null ? [] : snapshot1.data!,
                          );
                        }
                        else{
                          return Center(child: CircularProgressIndicator(
                            backgroundColor: settings.colorSelected,
                          ));
                        }
                      }
                  );
                }
            );
          }
          else{
            return Center(child: CircularProgressIndicator(
              backgroundColor: settings.colorSelected,
            ));
          }

        });
  }

}
