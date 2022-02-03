import 'dart:async';
import 'dart:io';

import 'package:frontendmobile/data/api_abstraction/data_class.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_hive/stash_hive.dart';

class StorageUtils{
  static final StorageUtils _cache = StorageUtils._internal();
  String defaultCacheName = "GetCache";
  String defaultVaultName = "PostWaitingVault";

  factory StorageUtils() {

    return _cache;
  }
  StorageUtils._internal();

  Future<HiveDefaultCacheStore> _getCacheStore(){
    return getApplicationDocumentsDirectory().then((value) => newHiveDefaultCacheStore(path: value.absolute.path));
  }

  Future<Cache<ApiDataClass>> getCache(String? cacheName) async {
    var store = await _getCacheStore();
    return store.cache<ApiDataClass>(
        name:cacheName ?? defaultCacheName,
        eventListenerMode: EventListenerMode.synchronous,
        expiryPolicy: const ModifiedExpiryPolicy(Duration(days: 7)) )
          ..on<CacheEntryCreatedEvent<ApiDataClass>>().listen(
                  (event) => print('Key "${event.entry.key}" added to the cache'));
  }

  Future<HiveDefaultVaultStore> _getVaultStore(){
    return getApplicationDocumentsDirectory().then((value) => newHiveDefaultVaultStore(path: value.absolute.path));
  }
  
  Future<Vault> getVault(String? vaultName) async {
    var store = await _getVaultStore();
    return
      store.vault(
        name:vaultName ?? defaultVaultName,
        eventListenerMode: EventListenerMode.synchronous
      )
      ..on<VaultEntryCreatedEvent>().listen(
              (event) => print('Key "${event.entry.key}" added to the vault'));
  }

  Future<void> addToDefaultVault(String path, ApiDataClass data) async {
    var vault = await getVault(defaultVaultName);
    return vault.put(path,data);
  }

  Future<void> addToDefaultCache(String path, ApiDataClass data) async {
    var vault = await getVault(defaultVaultName);
    return vault.put(path,data);
  }
}