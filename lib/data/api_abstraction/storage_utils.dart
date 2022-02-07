import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontendmobile/data/api_abstraction/api_commons.dart';
import 'package:frontendmobile/data/api_abstraction/data_class.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_hive/stash_hive.dart';
import 'package:stash_memory/stash_memory.dart';

import '../../main.dart';

class StorageUtils {
  static final StorageUtils _StorageUtils = StorageUtils._internal();
  String defaultCacheName = "GetCache";
  String defaultVaultName = "PostWaitingVault";
  String defaultFastCacheName = "FastGetCache";
  static final StreamController<int> _vaultSize = StreamController();
  static Stream<int> vaultSize = _vaultSize.stream.asBroadcastStream();
  static Map<String, DateTime> lastUpdate = {};
  factory StorageUtils() {
    return _StorageUtils;
  }
  StorageUtils._internal();

  bool noteUpdateAndCheckIfNotRecent(String key) {
    int timetime = 10;
    DateTime precedentUpdateTime = lastUpdate[key] ?? DateTime.now();
    lastUpdate[key] = DateTime.now();
    var result = DateTime.now()
        .subtract(Duration(seconds: timetime))
        .isAfter(precedentUpdateTime);
    //Logger().d("Dernier item ajouté il y a plus de $timetime secondes :" + (result ? "Oui":"Non"));
    return DateTime.now()
        .subtract(const Duration(seconds: 10))
        .isAfter(precedentUpdateTime);
  }

  Future<HiveDefaultCacheStore> _getCacheStore() {
    return getApplicationDocumentsDirectory()
        .then((value) => newHiveDefaultCacheStore(path: value.absolute.path));
  }

  Future<Cache<ApiDataClass>> getCache(String cacheName) async {
    var store = await _getCacheStore();
    return store.cache<ApiDataClass>(
        name: cacheName,
        eventListenerMode: EventListenerMode.synchronous,
        expiryPolicy: const ModifiedExpiryPolicy(Duration(days: 7)))
      ..on<CacheEntryCreatedEvent<ApiDataClass>>().listen(
          (event) => print('Key "${event.entry.key}" added to the cache'));
  }

  Future<Cache<ApiDataClass>> getDefaultCache() {
    return getCache(defaultCacheName);
  }

  MemoryCacheStore _getFastCacheStore() {
    return newMemoryCacheStore();
  }

  Future<Cache<ApiDataClass>> getFastCache() async {
    return _getFastCacheStore().cache(
        name: defaultCacheName,
        expiryPolicy: const ModifiedExpiryPolicy(Duration(seconds: 10)))
      ..on<CacheEntryCreatedEvent<ApiDataClass>>().listen(
          (event) => print('Key "${event.entry.key}" added to the fast cache'));
  }

  Future<HiveDefaultVaultStore> _getVaultStore() {
    return getApplicationDocumentsDirectory()
        .then((value) => newHiveDefaultVaultStore(path: value.absolute.path));
  }

  Future<Vault> getVault(String vaultName) async {
    var store = await _getVaultStore();
    var vault =  store.vault(
        name: vaultName, eventListenerMode: EventListenerMode.synchronous);
    vault.on<VaultEntryCreatedEvent>().listen(
            (event) => print('Key "${event.entry.key}" added to the vault'));
    vault.on<VaultEntryCreatedEvent>().listen((event) {
        if (noteUpdateAndCheckIfNotRecent(defaultVaultName)) {
          pushProcess();
        }
      });
    vault.on<VaultEntryCreatedEvent>().listen((event) async { _vaultSize.add(await event.source.size);});
    vault.on<VaultEntryRemovedEvent>().listen((event) async { _vaultSize.add(await event.source.size);});
    return vault;
  }

  Future<Vault<dynamic>> getDefaultVault() async {
    Vault va = await getVault(defaultVaultName);
    va.on().listen((event) async {_vaultSize.add(await event.source.size);});
    return va;
  }

  Future<void> addToDefaultVault(String path, ApiDataClass data) async {
    var vault = await getVault(defaultVaultName);
    return vault.put(path, data);
  }

  Future<void> addToDefaultCache(String path, ApiDataClass data) async {
    var cache = await getCache(defaultCacheName);
    return cache.put(path, data);
  }

  Future<void> addToFastCache(String path, ApiDataClass data) async {
    var fCache = await getFastCache();
    return fCache.put(path, data);
  }

  Future<void> addToCaches(String path, ApiDataClass data) async {
    await addToFastCache(path, data);
    await addToDefaultVault(path, data);
  }

  void pushProcess() {
    ApiCommons.sendToBack().then((value) => MyApp.log.d("Envoi terminé"));
  }

  Future<int> getDefaultVaultSize() async {
    var defVault = await getDefaultVault();
    return await defVault.size;
  }

}

enum SyncStatus{
  needed,
  notNeeded,
  prepaing,
  syncing
}