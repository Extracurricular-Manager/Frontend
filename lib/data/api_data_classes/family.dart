import 'package:frontendmobile/data/api_abstraction/data_class.dart';

class Family implements ApiDataClass {
  int? id;
  String? postalAdress;
  String? referingParentName;
  String? referingParentSurname;
  String? telephoneNumber;

  Family(
      {this.id,
      this.postalAdress,
      this.referingParentName,
      this.referingParentSurname,
      this.telephoneNumber});

  Family.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postalAdress = json['postalAdress'];
    referingParentName = json['referingParentName'];
    referingParentSurname = json['referingParentSurname'];
    telephoneNumber = json['telephoneNumber'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['postalAdress'] = postalAdress;
    data['referingParentName'] = referingParentName;
    data['referingParentSurname'] = referingParentSurname;
    data['telephoneNumber'] = telephoneNumber;
    return data;
  }
}
