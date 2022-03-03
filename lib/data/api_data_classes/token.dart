import 'package:frontendmobile/data/api_abstraction/data_class.dart';

class idtoken implements ApiDataClass{

  final String idToken;

  idtoken({required this.idToken});

  factory idtoken.fromJson(Map<String, dynamic> json) {
    return idtoken(
        idToken : json['id_token'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_token'] = idToken;
    return data;
  }
}