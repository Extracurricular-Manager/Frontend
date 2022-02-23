import 'package:frontendmobile/data/api_abstraction/data_class.dart';
import 'package:frontendmobile/data/api_data_classes/tarif.dart';

import 'adelphie.dart';
import 'classroom.dart';
import 'diet.dart';
import 'facturation.dart';
import 'grade_level.dart';

/*class ChildData implements ApiDataClass {
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

  @override
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['postalAdress'] = postalAdress;
    data['referingParentName'] = referingParentName;
    data['referingParentSurname'] = referingParentSurname;
    data['telephoneNumber'] = telephoneNumber;
    return data;
  }
}*/

class ChildData implements ApiDataClass {
  int? id;
  String? name;
  String? surname;
  String? birthday;
  Classroom? classroom;
  Adelphie? adelphie;
  GradeLevel? gradeLevel;
  List<Diets>? diets;
  Tarif? tarif;
  Facturation? facturation;

  ChildData(
      {this.id,
      this.name,
      this.surname,
      this.birthday,
      this.classroom,
      this.adelphie,
      this.gradeLevel,
      this.diets,
      this.tarif,
      this.facturation});

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
    tarif = json['tarif'] != null ? new Tarif.fromJson(json['tarif']) : null;
    facturation = json['facturation'] != null
        ? new Facturation.fromJson(json['facturation'])
        : null;
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
    if (this.tarif != null) {
      data['tarif'] = this.tarif!.toJson();
    }
    if (this.facturation != null) {
      data['facturation'] = this.facturation!.toJson();
    }
    return data;
  }
}
