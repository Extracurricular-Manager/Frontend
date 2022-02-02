import 'package:frontendmobile/data/api_abstraction/data_class.dart';

class Classroom implements ApiDataClass{
  int? id;
  String? name;
  String? professor;

  Classroom({this.id, this.name, this.professor});

  Classroom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    professor = json['professor'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['professor'] = professor;
    return data;
  }
}