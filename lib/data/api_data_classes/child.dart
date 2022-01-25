

import 'classroom.dart';
import 'diet.dart';
import 'grade_level.dart';

class ChildData {
  Adelphie? adelphie;
  String? birthday;
  Classroom? classroom;
  List<Diet>? diets;
  GradeLevel? gradeLevel;
  int? id;
  String? name;
  String? surname;

  ChildData(
      {this.adelphie,
        this.birthday,
        this.classroom,
        this.diets,
        this.gradeLevel,
        this.id,
        this.name,
        this.surname});

  ChildData.fromJson(Map<String, dynamic> json) {
    adelphie = json['adelphie'] != null
        ? Adelphie.fromJson(json['adelphie'])
        : null;
    birthday = json['birthday'];
    classroom = json['classroom'] != null
        ? Classroom.fromJson(json['classroom'])
        : null;
    if (json['diets'] != null) {
      diets = <Diet>[];
      json['diets'].forEach((v) {
        diets!.add(Diet.fromJson(v));
      });
    }
    gradeLevel = json['gradeLevel'] != null
        ? GradeLevel.fromJson(json['gradeLevel'])
        : null;
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (adelphie != null) {
      data['adelphie'] = adelphie!.toJson();
    }
    data['birthday'] = birthday;
    if (classroom != null) {
      data['classroom'] = classroom!.toJson();
    }
    if (diets != null) {
      data['diets'] = diets!.map((v) => v.toJson()).toList();
    }
    if (gradeLevel != null) {
      data['gradeLevel'] = gradeLevel!.toJson();
    }
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    return data;
  }
}

class Adelphie {
  int? id;
  String? postalAdress;
  String? referingParentName;
  String? referingParentSurname;
  String? telephoneNumber;

  Adelphie(
      {this.id,
        this.postalAdress,
        this.referingParentName,
        this.referingParentSurname,
        this.telephoneNumber});

  Adelphie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postalAdress = json['postalAdress'];
    referingParentName = json['referingParentName'];
    referingParentSurname = json['referingParentSurname'];
    telephoneNumber = json['telephoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postalAdress'] = this.postalAdress;
    data['referingParentName'] = this.referingParentName;
    data['referingParentSurname'] = this.referingParentSurname;
    data['telephoneNumber'] = this.telephoneNumber;
    return data;
  }
}