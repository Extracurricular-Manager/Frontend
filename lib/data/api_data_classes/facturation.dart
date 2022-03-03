import 'package:frontendmobile/data/api_abstraction/data_class.dart';

class Facturation implements ApiDataClass {
  int? id;
  String? schoolService;
  int? cost;
  bool? payed;

  Facturation({this.id, this.schoolService, this.cost, this.payed});

  Facturation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolService = json['schoolService'];
    cost = json['cost'];
    payed = json['payed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['schoolService'] = this.schoolService;
    data['cost'] = this.cost;
    data['payed'] = this.payed;
    return data;
  }
}
