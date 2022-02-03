import 'dart:convert';
import 'dart:io';

import 'package:frontendmobile/data/api_abstraction/api_basic_endpoint.dart';
import 'package:frontendmobile/data/api_abstraction/data_class.dart';
import 'package:frontendmobile/data/api_abstraction/network_utils.dart';
import 'package:frontendmobile/data/api_abstraction/storage_utils.dart';
import 'package:http/http.dart' as http;

class ApiCommons {
  static final ApiCommons _api = ApiCommons._internal();

  factory ApiCommons() {
    return _api;
  }

  ApiCommons._internal();

  String baseUrl = "/api";

  /// basic get operation (options currently passed through the endpoint parameter)
  Future<T> getOperation<T>(BasicApiEndpoint apiClass, String endpoint) async {
    final generatedUrl = baseUrl + apiClass.baseUrl + endpoint;
    final response = await http.get(Uri.parse(generatedUrl));

    if (response.statusCode == HttpStatus.ok) {
      var cache = await StorageUtils().getDefaultCache();
      var result = apiClass.createFromJson(jsonDecode(response.body));
      cache.put(generatedUrl, result);
      return result;
    } else {
      throw Exception('Failed to load ' + generatedUrl);
    }
  }

  static Future<bool> SendToBack() async {
    bool result = true;
    var vault = await StorageUtils().getDefaultVault();
    var cache = await StorageUtils().getDefaultCache();
    var keys = await vault.keys;
    if (await NetworkUtils.getConnectivity() == NetworkStatus.ok) {
      //POST
      for (var key in keys) {
        var data = await vault.get(key);
        var postStatut = await postOperation(key, data);
        if (postStatut.statusCode == HttpStatus.ok) {
          await vault.remove(key);
          await cache.put(key, data);
        } else {
          //TODO : AJOUTER LA PRISE EN CHARGE DU CODE HTTP 210 (CHANGEMENT DE TOKEN)
          result = false;
        }
      }
    }
    return result;
  }

  Future<void> pushDataToQueue<T>(
      BasicApiEndpoint apiClass, String endpoint, dynamic data) {
    final generatedUrl = baseUrl + apiClass.baseUrl + endpoint;
    return StorageUtils().addToDefaultVault(generatedUrl, data as ApiDataClass);
  }

  static Future<http.Response> postOperation<T>(String url, ApiDataClass data) {
    return http.post(Uri.parse(url), body: data);
  }

  Future<T> putOperation<T>(
      BasicApiEndpoint sourceClass, String endpoint) async {
    final generatedUrl = baseUrl + sourceClass.baseUrl + endpoint;
    final response = await http.put(Uri.parse(generatedUrl));
    if (response.statusCode == HttpStatus.ok) {
      return sourceClass.createFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load ' + generatedUrl);
    }
  }

  Future<T> patchOperation<T>(
      BasicApiEndpoint sourceClass, String endpoint) async {
    final generatedUrl = baseUrl + sourceClass.baseUrl + endpoint;
    final response = await http.patch(Uri.parse(generatedUrl));
    if (response.statusCode == HttpStatus.ok) {
      return sourceClass.createFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load ' + generatedUrl);
    }
  }
}
