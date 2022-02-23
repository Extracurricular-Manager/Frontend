import 'package:frontendmobile/data/api_abstraction/data_class.dart';

class Tarif implements ApiDataClass {
  int? id;
  int? price;
  String? name;
  String? comment;

  Tarif({this.id, this.price, this.name, this.comment});

  Tarif.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['name'] = this.name;
    data['comment'] = this.comment;
    return data;
  }
}
