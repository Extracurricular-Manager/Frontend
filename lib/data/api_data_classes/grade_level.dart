class GradeLevel {
  int? id;
  String? level;

  GradeLevel({this.id, this.level});

  GradeLevel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['level'] = level;
    return data;
  }
}