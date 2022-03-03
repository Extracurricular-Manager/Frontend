import 'package:frontendmobile/data/api_abstraction/data_class.dart';

import 'child.dart';

class Presences implements ApiDataClass {

  final int id;
  final int serviceId;
  final String name;
  final bool presence;
  final date;
  final ChildData child;

  Presences({required this.id, required this.serviceId, required this.name, required this.presence, required this.date, required this.child});

  factory Presences.fromJson(Map<String , dynamic> json) {
    return Presences(
        id: json['id'] as int,
        serviceId: json['serviceId'] as int,
        name: json['name'] as String,
        presence: json['presence'] as bool,
        date: json['date'],
        child: ChildData.fromJson(json["child"]),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['serviceId'] = serviceId;
    data['name'] = name;
    data['presence'] = presence;
    data['date'] = date;
    data['child'] = child;
    return data;
  }

}