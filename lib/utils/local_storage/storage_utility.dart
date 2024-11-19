import 'package:get_storage/get_storage.dart';

class SLocalStorage {
  late final GetStorage _storage;

  // Singleton instance
  static SLocalStorage? _instance;

  // Private constructor
  SLocalStorage._internal();

  // Factory constructor to return the singleton instance
  factory SLocalStorage.instance() {
    _instance ??= SLocalStorage._internal();
    return _instance!;
  }

  // Asynchronous initialization method
  static Future<void> init(String bucketName) async {
    // Check if the instance is already initialized
    if (_instance == null) {
      await GetStorage.init(bucketName);
      _instance ??= SLocalStorage._internal();
      _instance!._storage = GetStorage();
    }
  }

  // Generic method to save data
  Future<void> saveData<S>(String key, S value) async {
    await _storage.write(key, value);
  }

  // Generic method to save data
  Future<void> writeData<S>(String key, S value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  S? readData<S>(String key) {
    return _storage.read<S>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Method to clear all data from storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
