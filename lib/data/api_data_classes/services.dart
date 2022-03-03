import 'package:frontendmobile/data/api_abstraction/data_class.dart';

class Services implements ApiDataClass {

  final int id;
  final String name;
  final String model;
  final String icon;


  Services({required this.id, required this.name, required this.model, required this.icon});

  factory Services.fromJson(Map<String , dynamic> json) {
    return Services(
        id: json['id'] as int,
        name: json['name'] as String,
        model: json['model'] as String,
        icon: json['icon'] as String
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model'] = model;
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    return data;
  }
}