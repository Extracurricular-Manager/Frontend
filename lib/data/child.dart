import 'package:frontendmobile/data/api_abstraction/api_basic_endpoint.dart';
import 'package:frontendmobile/data/api_abstraction/api_commons.dart';
import 'package:frontendmobile/data/api_data_classes/child.dart';

class Child implements BasicApiEndpoint{
  @override
  String baseUrl = "/child";

  @override
  ChildData createFromJson(parms) {
    return ChildData.fromJson(parms);
  }

  Future<ChildData> getFromId<ChildData>(int id){
    return ApiCommons().getOperation(this, id.toString());
  }

}