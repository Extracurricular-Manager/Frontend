import 'dart:convert';

import 'package:frontendmobile/data/api_abstraction/api_basic_endpoint.dart';
import 'package:http/http.dart' as http;

class ApiCommons {
  static final ApiCommons _api = ApiCommons._internal();

  factory ApiCommons() {
    return _api;
  }

  ApiCommons._internal();

  String baseUrl = "/api";

  Future<T> getOperation<T>(BasicApiEndpoint sourceClass, String endpoint) async {
    final generatedUrl = baseUrl+sourceClass.baseUrl+endpoint;
    final response = await http.get(Uri.parse(generatedUrl));
      if (response.statusCode == 200) {
        return sourceClass.createFromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load '+generatedUrl);
      }
    }
  }


