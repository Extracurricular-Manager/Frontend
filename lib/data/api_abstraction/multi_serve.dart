import 'package:flutter/material.dart';
import 'package:frontendmobile/data/api_abstraction/storage_utils.dart';
import 'package:stash/stash_api.dart';

class MultiServe{

  Future<Vault> getServersVault() async{
    return await StorageUtils().getVault("servers");
  }

  static bool loginUserForServer(String serverId, String username, String password){
    return false;
  }

  static bool updateAndSaveServerData(){
    return false;
  }

}


class ServerProperties {
  String? id;
  String? name;
  String? url;
  Colors? color;
  String? token;

  ServerProperties({this.id, this.name, this.url, this.color, this.token});

  ServerProperties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    color = json['color'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    data['color'] = this.color;
    data['token'] = this.token;
    return data;
  }
}