import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageRepository {
  final storage = new FlutterSecureStorage();

  Future<String?> getStoredValue(String key) async {
    try {
      return await storage.read(key: key);
    } catch (e) {
      return null;
    }
  }

  Future<void> storeValue(String key, String value) async {
    try {
      return await storage.write(key: key, value: value);
    } catch (e) {
      // TODO WEB으로 실행하면 LocalStorage는 동작하지 않아 여기로 빠진다
      print(e);
      return;
    }
  }

  Future<void> deleteStoredValue(String key) async {
    try {
      return await storage.delete(key: key);
    } catch (e) {
      rethrow;
    }
  }
}
