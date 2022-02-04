import 'dart:convert';
import 'dart:io';

import 'package:frontendmobile/data/api_abstraction/api_basic_endpoint.dart';
import 'package:frontendmobile/data/api_abstraction/data_class.dart';
import 'package:frontendmobile/data/api_abstraction/network_utils.dart';
import 'package:frontendmobile/data/api_abstraction/storage_utils.dart';
import 'package:frontendmobile/main.dart';
import 'package:http/http.dart' as http;
import 'package:stash/stash_api.dart';

class ApiCommons {
  static final ApiCommons _api = ApiCommons._internal();
  static SyncStatus status = SyncStatus.notNeeded;
  static int queueSize = 0;
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
      var result = apiClass.createFromJson(jsonDecode(response.body));
      return result;
    } else {
      throw Exception('Failed to load ' + generatedUrl);
    }
  }

  static Future<bool> sendToBack() async {
    status = SyncStatus.prepaing;
    MyApp.status.add(SyncStatus.prepaing);
    MyApp.log.i("Lancement du process d'envoi au back");
    bool result = true;
    var vault = await StorageUtils().getDefaultVault();
    var cache = await StorageUtils().getDefaultCache();
    var keys = await vault.keys;
    if (await NetworkUtils.getConnectivity() == NetworkStatus.ok) {
      MyApp.log.d("Connexion possible. Début du process d'envoi");
      status = SyncStatus.syncing;
      MyApp.status.add(SyncStatus.syncing);
      for (var key in keys) {
        var data = await vault.get(key);
        var postStatut = await postOperation(key, data);
        if (postStatut.statusCode == HttpStatus.ok) {
          await vault.remove(key);
          await cache.put(key, data);
          _updateQueueNumber(vault);
        } else {
          //TODO : AJOUTER LA PRISE EN CHARGE DU CODE HTTP 210 (CHANGEMENT DE TOKEN)
          result = false;
        }
      }
    } else {
      MyApp.log.w("Pas de connexion au serveur.");
      if(await vault.size > 0){
        status = SyncStatus.needed;
        MyApp.status.add(SyncStatus.needed);
      }
      MyApp.status.add(SyncStatus.needed);
    }
    if(await vault.size == 0){
      status = SyncStatus.notNeeded;
      MyApp.status.add(SyncStatus.notNeeded);
    }
    return result;
  }

  Future<void> push<T>(
      BasicApiEndpoint apiClass, String endpoint, dynamic data) async {
    pushDataToQueue(apiClass, endpoint, data);
  }

  static Future<void> _updateQueueNumber(Vault vault) async {
    queueSize = await vault.size;
  }

  Future<ApiDataClass?> fetch(
      BasicApiEndpoint apiClass, String endpoint) async {
    var fastCache = await StorageUtils().getFastCache();
    var cache = await StorageUtils().getDefaultCache();
    final generatedUrl = baseUrl + apiClass.baseUrl + endpoint;
    var fastResult = await fastCache.get(generatedUrl);
    if (fastResult == null) {
      switch (await NetworkUtils.getConnectivity()) {
        case NetworkStatus.ok:
          var result = await getOperation(apiClass, endpoint);
          await StorageUtils().addToCaches(generatedUrl, result);
          return result;
        default:
          return cache.get(generatedUrl);
      }
    } else {
      return fastResult;
    }
  }


  Future<void> pushDataToQueue<T> (
      BasicApiEndpoint apiClass, String endpoint, dynamic data) async {
    status = SyncStatus.needed;
    MyApp.status.add(SyncStatus.needed);
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
