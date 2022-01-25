class Diet {
  String? description;
  int? id;
  String? name;

  Diet({this.description, this.id, this.name});

  Diet.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}