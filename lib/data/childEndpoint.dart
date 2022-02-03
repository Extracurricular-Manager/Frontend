import 'package:frontendmobile/data/api_abstraction/api_basic_endpoint.dart';
import 'package:frontendmobile/data/api_abstraction/api_commons.dart';
import 'package:frontendmobile/data/api_abstraction/data_class.dart';
import 'package:frontendmobile/data/api_abstraction/storage_utils.dart';
import 'package:frontendmobile/data/api_data_classes/child.dart';

class ChildEndpoint implements BasicApiEndpoint{
  @override
  String baseUrl = "/child";

  @override
  ChildData createFromJson(parms) {
    return ChildData.fromJson(parms);
  }

  Future<ChildData> getFromId<ChildData>(int id){
    return ApiCommons().getOperation(this, id.toString());
  }

  Future<void> push<ChildData>(ChildData childToPush) async{
    String endpointPath = "/$childToPush.id";
    return ApiCommons().pushDataToQueue(this, endpointPath, childToPush);
  }

}