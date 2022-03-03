import 'package:frontendmobile/data/api_abstraction/data_class.dart';

import 'child.dart';

class Period implements ApiDataClass {

  final int id;
  final int serviceId;
  //final String name;
  final String timeOfArrival;
  final String timeOfDeparture;
  final String timeOfStartBilling;
  //final ChildData child;

  Period(
      {required this.id, required this.serviceId,/* required this.name,*/ required this.timeOfArrival, required this.timeOfDeparture, required this.timeOfStartBilling/*, required this.child*/});

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      id: json['id'] as int,
      serviceId: json['serviceId'] as int,
      //name: json['name'] as String,
      timeOfArrival: json['timeOfArrival'] as String,
      timeOfDeparture: json['timeOfDeparture'] as String,
      timeOfStartBilling: json['timeOfStartBilling'] as String,
     // child: ChildData.fromJson(json["child"]),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['serviceId'] = serviceId;
   // data['name'] = name;
    data['timeOfArrival'] = timeOfArrival;
    data['timeOfDeparture'] = timeOfDeparture;
    data['timeOfStartBilling'] = timeOfStartBilling;
    //data['child'] = child;
    return data;
  }
}
