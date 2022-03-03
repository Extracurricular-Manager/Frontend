import 'package:frontendmobile/data/api_abstraction/data_class.dart';

class ChildData implements ApiDataClass {
  late int id;
  late String name;
  late String surname;
  late String birthday;
 // late Classroom classroom;
  //late Adelphie adelphie;
  late GradeLevel gradeLevel;
  //late List<Diet> diets;
  //late Facturation facturation;

  ChildData(
      {required this.id,
      required this.name,
      required this.surname,
      required this.birthday,
     // required this.classroom,
     // required this.adelphie,
     // required this.diets,
      required this.gradeLevel,
      //required this.facturation
    });

  factory ChildData.fromJson(Map<String, dynamic> json) {
    return ChildData(
        id: json['id'] as int,
        name: json['name'] as String,
        surname: json['surname'] as String,
        birthday: json['birthday'] as String,
       // classroom: Classroom.fromJson(json['classroom']),//json['classroom'] as Classroom,
       // adelphie: Adelphie.fromJson(json['adelphie']),
        gradeLevel: GradeLevel.fromJson(json['gradeLevel']),
        //diets: json[Diet.fromJson(json['diets'])] as List<Diet>,
        //facturation: Facturation.fromJson(json['facturation'])
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['birthday'] = birthday;
   // data['classroom'] = classroom;
   // data['adelphie'] = adelphie;
   // data['diets'] = diets;
    data['gradeLevel'] = gradeLevel;
    //data['facturation'] = facturation;
    return data;
  }
}

class Classroom{

  late int? id;
  late String? name;
  late String? professor;

  Classroom({
     this.id,
     this.name,
     this.professor,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      id : json['id'] as int,
      name : json['name'] as String,
      professor : json['professor'] as String,
    );

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

class Adelphie {

  late int id;
  late String referingParentName;
  late String referingParentSurname;
  late String telephoneNumber;
  late String postalAdress;

  Adelphie({
    required this.id,
    required this.referingParentName,
    required this.referingParentSurname,
    required this.telephoneNumber,
    required this.postalAdress,
  });

  Adelphie.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    referingParentName = json['referingParentName'] as String;
    referingParentSurname = json['referingParentSurname'] as String;
    telephoneNumber = json['telephoneNumber'] as String;
    postalAdress = json['postalAdress'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['referingParentName'] = referingParentName;
    data['referingParentSurname'] = referingParentSurname;
    data['telephoneNumber'] = telephoneNumber;
    data['postalAdress'] = postalAdress;
    return data;
  }
}

class GradeLevel{

  late int id;
  late String level;

  GradeLevel({
    required this.id,
    required this.level,
  });

  GradeLevel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    level = json['level'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['level'] = level;
    return data;
  }
}

class Diet{

   int? id;
   String? name;
   String? description;

  Diet({
     this.id,
     this.name,
     this.description,
  });

  Diet.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    description = json['description'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class Facturation {
  int id;
  String schoolService;
  int cost;
  bool payed;

  Facturation(
      {required this.id,
      required this.schoolService,
      required this.cost,
      required this.payed});

  factory Facturation.fromJson(Map<String, dynamic> json) {
    return Facturation(
        id: json['id'] as int,
        schoolService: json['schoolService'] as String,
        cost: json['cost'] as int,
        payed: json['payed'] as bool);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['schoolService'] = schoolService;
    data['cost'] = cost;
    data['payed'] = payed;
    return data;
  }
}
