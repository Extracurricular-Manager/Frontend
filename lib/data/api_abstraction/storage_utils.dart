import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontendmobile/data/api_abstraction/data_class.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_hive/stash_hive.dart';

class StorageUtils{
  static final StorageUtils _StorageUtils = StorageUtils._internal();
  String defaultCacheName = "GetCache";
  String defaultVaultName = "PostWaitingVault";
  static Map<String, DateTime> lastUpdate = {};
  factory StorageUtils() {
    return _StorageUtils;
  }
  StorageUtils._internal();

bool noteUpdateAndCheckIfNotRecent(String key){
  int timetime = 10;
  DateTime precedentUpdateTime = lastUpdate[key] ?? DateTime.now();
  lastUpdate[key] = DateTime.now();
  var result = DateTime.now().subtract(Duration(seconds: timetime)).isAfter(precedentUpdateTime);
  //Logger().d("Dernier item ajouté il y a plus de $timetime secondes :" + (result ? "Oui":"Non"));
  return DateTime.now().subtract(const Duration(seconds: 10)).isAfter(precedentUpdateTime);
}

  Future<HiveDefaultCacheStore> _getCacheStore(){
    return getApplicationDocumentsDirectory().then((value) => newHiveDefaultCacheStore(path: value.absolute.path));
  }

  Future<Cache<ApiDataClass>> getCache(String cacheName) async {
    var store = await _getCacheStore();
    return store.cache<ApiDataClass>(
        name:cacheName,
        eventListenerMode: EventListenerMode.synchronous,
        expiryPolicy: const ModifiedExpiryPolicy(Duration(days: 7)) )
          ..on<CacheEntryCreatedEvent<ApiDataClass>>().listen(
                  (event) => print('Key "${event.entry.key}" added to the cache'));
  }

  Future<Cache<ApiDataClass>> getDefaultCache (){
  return getCache(defaultCacheName);
  }



  Future<HiveDefaultVaultStore> _getVaultStore(){
    return getApplicationDocumentsDirectory().then((value) => newHiveDefaultVaultStore(path: value.absolute.path));
  }

  Future<Vault> getVault(String vaultName) async {
    var store = await _getVaultStore();
    return
      store.vault(
        name:vaultName,
        eventListenerMode: EventListenerMode.synchronous
      )
      ..on<VaultEntryCreatedEvent>().listen(
              (event) => print('Key "${event.entry.key}" added to the vault'))
    ..on<VaultEntryCreatedEvent>().listen((event) {
      if(noteUpdateAndCheckIfNotRecent(defaultVaultName)){pushProcess();}
    });
  }

  Future<Vault<dynamic>> getDefaultVault (){
    return getVault(defaultVaultName);
  }

  Future<void> addToDefaultVault(String path, ApiDataClass data) async {
    var vault = await getVault(defaultVaultName);
    return vault.put(path,data);
  }

  Future<void> addToDefaultCache(String path, ApiDataClass data) async {
    var vault = await getVault(defaultVaultName);
    return vault.put(path,data);
  }

  void pushProcess(){
  }

}