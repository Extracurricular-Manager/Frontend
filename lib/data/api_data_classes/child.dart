import 'package:frontendmobile/data/api_abstraction/data_class.dart';

class ChildData implements ApiDataClass {
  int? id;
  String? name;
  String? surname;
  String? birthday;
  Classroom? classroom;
  Adelphie? adelphie;
  GradeLevel? gradeLevel;
  List<Diets>? diets;
  List<MonthPaid>? monthPaid;

  ChildData(
      {this.id,
      this.name,
      this.surname,
      this.birthday,
      this.classroom,
      this.adelphie,
      this.gradeLevel,
      this.diets,
      this.monthPaid});

  ChildData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    birthday = json['birthday'];
    classroom = json['classroom'] != null
        ? new Classroom.fromJson(json['classroom'])
        : null;
    adelphie = json['adelphie'] != null
        ? new Adelphie.fromJson(json['adelphie'])
        : null;
    gradeLevel = json['gradeLevel'] != null
        ? new GradeLevel.fromJson(json['gradeLevel'])
        : null;
    if (json['diets'] != null) {
      diets = <Diets>[];
      json['diets'].forEach((v) {
        diets!.add(new Diets.fromJson(v));
      });
    }
    if (json['monthPaid'] != null) {
      monthPaid = <MonthPaid>[];
      json['monthPaid'].forEach((v) {
        monthPaid!.add(new MonthPaid.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['birthday'] = this.birthday;
    if (this.classroom != null) {
      data['classroom'] = this.classroom!.toJson();
    }
    if (this.adelphie != null) {
      data['adelphie'] = this.adelphie!.toJson();
    }
    if (this.gradeLevel != null) {
      data['gradeLevel'] = this.gradeLevel!.toJson();
    }
    if (this.diets != null) {
      data['diets'] = this.diets!.map((v) => v.toJson()).toList();
    }
    if (this.monthPaid != null) {
      data['monthPaid'] = this.monthPaid!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Classroom implements ApiDataClass {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['professor'] = this.professor;
    return data;
  }
}

class Adelphie implements ApiDataClass {
  int? id;
  String? referingParentName;
  String? referingParentSurname;
  String? telephoneNumber;
  String? postalAdress;

  Adelphie(
      {this.id,
      this.referingParentName,
      this.referingParentSurname,
      this.telephoneNumber,
      this.postalAdress});

  Adelphie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referingParentName = json['referingParentName'];
    referingParentSurname = json['referingParentSurname'];
    telephoneNumber = json['telephoneNumber'];
    postalAdress = json['postalAdress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['referingParentName'] = this.referingParentName;
    data['referingParentSurname'] = this.referingParentSurname;
    data['telephoneNumber'] = this.telephoneNumber;
    data['postalAdress'] = this.postalAdress;
    return data;
  }
}

class GradeLevel implements ApiDataClass {
  int? id;
  String? level;

  GradeLevel({this.id, this.level});

  GradeLevel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level'] = this.level;
    return data;
  }
}

class MonthPaid implements ApiDataClass {
  int? id;
  List<int>? date;
  int? cost;
  bool? payed;

  MonthPaid({this.id, this.date, this.cost, this.payed});

  MonthPaid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'].cast<int>();
    cost = json['cost'];
    payed = json['payed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['cost'] = this.cost;
    data['payed'] = this.payed;
    return data;
  }
}

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
