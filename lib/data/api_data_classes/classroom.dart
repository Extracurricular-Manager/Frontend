class Classroom {
  int? id;
  String? name;
  String? professor;

  Classroom({this.id, this.name, this.professor});

  Classroom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    professor = json['professor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['professor'] = professor;
    return data;
  }
}