import 'dart:convert';
import 'dart:io';

import 'package:frontendmobile/data/api_abstraction/api_basic_endpoint.dart';
import 'package:frontendmobile/data/api_abstraction/data_class.dart';
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
  Future<T> getOperation<T>(
      BasicApiEndpoint apiClass, String endpoint) async {
    final generatedUrl = baseUrl + apiClass.baseUrl + endpoint;
    final response = await http.get(Uri.parse(generatedUrl));
    if (response.statusCode == HttpStatus.ok) {
      return apiClass.createFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load ' + generatedUrl);
    }
  }

  Future<void> pushDataToQueue<T>(BasicApiEndpoint apiClass, String endpoint, dynamic data){
    final generatedUrl = baseUrl + apiClass.baseUrl + endpoint;
    return StorageUtils().addToDefaultVault(generatedUrl, data as ApiDataClass);
  }

  Future<T> postOperation<T>(
      BasicApiEndpoint sourceClass, String endpoint) async {
    final generatedUrl = baseUrl + sourceClass.baseUrl + endpoint;
    final response = await http.post(Uri.parse(generatedUrl));
    if (response.statusCode == HttpStatus.ok) {
      return sourceClass.createFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load ' + generatedUrl);
    }
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
