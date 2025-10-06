import 'package:hive_flutter/adapters.dart';

import 'local_storage.dart';

class HiveLocalStorage implements LocalStorage {
  @override
  Future<dynamic> load({required String key, String? boxName}) async {
    final box = await Hive.openBox(boxName!);
    try {
      return box.get(key);
    } catch (_) {
      rethrow;
    } finally {
      // await box.close(); // Optional: only if you're sure it won't be reused soon
    }
  }

  @override
  Future<void> save({
    required String key,
    required dynamic value,
    String? boxName,
  }) async {
    final box = await Hive.openBox(boxName!);
    try {
      await box.put(key, value);
    } catch (_) {
      rethrow;
    } finally {
      //   await box.close(); // Optional
    }
  }

  @override
  Future<void> delete({required String key, String? boxName}) async {
    final box = await Hive.openBox(boxName!);
    try {
      await box.delete(key);
    } catch (_) {
      rethrow;
    } finally {
      //   await box.close(); // Optional
    }
  }
}
