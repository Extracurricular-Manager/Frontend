import 'package:frontendmobile/data/api_abstraction/data_class.dart';

class Diets implements ApiDataClass {
  String? description;
  int? id;
  String? name;

  Diets({this.description, this.id, this.name});

  Diets.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    name = json['name'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}