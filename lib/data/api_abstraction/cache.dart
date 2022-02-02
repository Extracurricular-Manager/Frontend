import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_hive/stash_hive.dart';

class Cache{
  static final Cache _cache = Cache._internal();
  static final directory = getCurrentPath();
  static late var store = newHiveDefaultVaultStore(path: directory);
  static late var volt = store.vault(name: 'vault', eventListenerMode: EventListenerMode.synchronous)
  ..on<VaultEntryCreatedEvent>().listen(
  (event) => print('Key "${event.entry.key}" added to the vault'));

  factory Cache() {

    volt.put(
        'task1', "hello there");

    return _cache;
  }
  Cache._internal();


  static String getCurrentPath()  {
    String? result;
    getApplicationDocumentsDirectory().then((value) => result = value.toString());
    while (result == null){
      sleep(const Duration(milliseconds: 10));
    }
    return result!;
  }

}