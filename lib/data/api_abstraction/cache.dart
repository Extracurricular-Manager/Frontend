import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_hive/stash_hive.dart';

class Cache{
  static final Cache _cache = Cache._internal();
  static late var store;

  factory Cache() {

    return _cache;
  }
  Cache._internal();

  Future<HiveDefaultVaultStore> getStore(){
    return getApplicationDocumentsDirectory().then((value) => newHiveDefaultVaultStore(path: value.absolute.path));
  }
  
  Future<Vault> getVault(String vaultName) async {
    var store = await getStore();
    return store.vault(name:vaultName, eventListenerMode: EventListenerMode.synchronous)
      ..on<VaultEntryCreatedEvent>().listen(
              (event) => print('Key "${event.entry.key}" added to the vault'));
  }
}