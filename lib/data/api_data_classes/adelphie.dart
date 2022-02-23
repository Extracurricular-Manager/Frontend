import 'package:frontendmobile/data/api_abstraction/data_class.dart';

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
