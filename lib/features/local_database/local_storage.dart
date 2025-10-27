import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

final localStorageProvider = Provider((ref) => LocalStorage.instance);

/// A comprehensive service class for GetStorage operations
class LocalStorage {
  static LocalStorage? _instance;
  static GetStorage? _storage;

  // Private constructor
  LocalStorage._internal();

  static LocalStorage get instance {
    _instance ??= LocalStorage._internal();
    return _instance!;
  }

  static Future<bool> init({
    String container = 'AppStorage',
    Map<String, dynamic>? initialData,
  }) async {
    try {
      await GetStorage.init(container);
      _storage = GetStorage(container);

      // Write initial data if provided and storage is empty
      if (initialData != null && _storage!.getKeys()) {
        for (final entry in initialData.entries) {
          await _storage!.write(entry.key, entry.value);
        }
      }

      developer.log(
        '✅ Storage initialized successfully',
        name: 'StorageService',
      );
      return true;
    } catch (e) {
      developer.log(
        '❌ Storage initialization failed: $e',
        name: 'StorageService',
      );
      return false;
    }
  }

  /// Check if storage is initialized
  bool get isInitialized => _storage != null;

  /// Ensure storage is initialized before operations
  void _ensureInitialized() {
    if (!isInitialized) {
      throw Exception(
        'StorageService not initialized. Call StorageService.init() first.',
      );
    }
  }

  // ==================== BASIC OPERATIONS ====================
  Future<bool> write(String key, dynamic value) async {
    try {
      _ensureInitialized();
      await _storage!.write(key, value);
      developer.log('✅ Write successful: $key', name: 'StorageService');
      return true;
    } catch (e) {
      developer.log('❌ Write failed for key $key: $e', name: 'StorageService');
      return false;
    }
  }

  Future<bool> writeIfNull(String key, dynamic value) async {
    try {
      _ensureInitialized();
      if (!hasData(key)) {
        await _storage!.write(key, value);
        developer.log('✅ WriteIfNull successful: $key', name: 'StorageService');
        return true;
      }
      developer.log(
        '⚠️ Key already exists, skipping write: $key',
        name: 'StorageService',
      );
      return false;
    } catch (e) {
      developer.log(
        '❌ WriteIfNull failed for key $key: $e',
        name: 'StorageService',
      );
      return false;
    }
  }

  T? read<T>(String key, {T? defaultValue}) {
    try {
      _ensureInitialized();
      final value = _storage!.read<T>(key);
      return value ?? defaultValue;
    } catch (e) {
      developer.log('❌ Read failed for key $key: $e', name: 'StorageService');
      return defaultValue;
    }
  }

  Future<bool> remove(String key) async {
    try {
      _ensureInitialized();
      await _storage!.remove(key);
      developer.log('✅ Remove successful: $key', name: 'StorageService');
      return true;
    } catch (e) {
      developer.log('❌ Remove failed for key $key: $e', name: 'StorageService');
      return false;
    }
  }

  Future<bool> clear() async {
    try {
      _ensureInitialized();
      await _storage!.erase();
      developer.log('✅ Storage cleared successfully', name: 'StorageService');
      return true;
    } catch (e) {
      developer.log('❌ Clear failed: $e', name: 'StorageService');
      return false;
    }
  }

  bool hasData(String key) {
    try {
      _ensureInitialized();
      return _storage!.hasData(key);
    } catch (e) {
      developer.log(
        '❌ HasData check failed for key $key: $e',
        name: 'StorageService',
      );
      return false;
    }
  }

  /// some utilities
  /// Get all keys in storage
  List<String> getAllKeys() {
    try {
      _ensureInitialized();
      final keys = _storage!.getKeys<List<dynamic>>();
      return List<String>.from(keys ?? []);
    } catch (e) {
      developer.log('❌ GetAllKeys failed: $e', name: 'StorageService');
      return [];
    }
  }

  /// Get all values in storage
  Map<String, dynamic> getAllValues() {
    try {
      _ensureInitialized();
      return _storage!.getValues<Map<String, dynamic>>() ?? {};
    } catch (e) {
      developer.log('❌ GetAllValues failed: $e', name: 'StorageService');
      return {};
    }
  }

  // ==================== COMPLEX DATA OPERATIONS ====================

  /// Write JSON object (automatically converts to JSON)
  Future<bool> writeJson(String key, Map<String, dynamic> jsonData) async {
    try {
      _ensureInitialized();
      await _storage!.write(key, jsonData);
      developer.log('✅ JSON write successful: $key', name: 'StorageService');
      return true;
    } catch (e) {
      developer.log(
        '❌ JSON write failed for key $key: $e',
        name: 'StorageService',
      );
      return false;
    }
  }

  /// Read JSON object
  Map<String, dynamic>? readJson(String key) {
    try {
      _ensureInitialized();
      final value = _storage!.read(key);
      if (value is Map<String, dynamic>) {
        return value;
      } else if (value is String) {
        return jsonDecode(value) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      developer.log(
        '❌ JSON read failed for key $key: $e',
        name: 'StorageService',
      );
      return null;
    }
  }

  /// Write list data
  Future<bool> writeList(String key, List<dynamic> listData) async {
    try {
      _ensureInitialized();
      await _storage!.write(key, listData);
      developer.log('✅ List write successful: $key', name: 'StorageService');
      return true;
    } catch (e) {
      developer.log(
        '❌ List write failed for key $key: $e',
        name: 'StorageService',
      );
      return false;
    }
  }

  /// Read list data
  List<T>? readList<T>(String key) {
    try {
      _ensureInitialized();
      final value = _storage!.read(key);
      if (value is List) {
        return List<T>.from(value);
      }
      return null;
    } catch (e) {
      developer.log(
        '❌ List read failed for key $key: $e',
        name: 'StorageService',
      );
      return null;
    }
  }

  // ==================== BATCH OPERATIONS ====================
  /// Remove multiple keys
  Future<bool> removeBatch(List<String> keys) async {
    try {
      _ensureInitialized();
      for (final key in keys) {
        await _storage!.remove(key);
      }
      developer.log(
        '✅ Batch remove successful: ${keys.length} items',
        name: 'StorageService',
      );
      return true;
    } catch (e) {
      developer.log('❌ Batch remove failed: $e', name: 'StorageService');
      return false;
    }
  }

  /// Print all storage data (debug mode only)
  void debugPrintAll() {
    if (kDebugMode) {
      try {
        _ensureInitialized();
        final allData = getAllValues();
        developer.log('📊 Storage Debug Data:', name: 'StorageService');
        for (final entry in allData.entries) {
          developer.log(
            '  ${entry.key}: ${entry.value}',
            name: 'StorageService',
          );
        }
      } catch (e) {
        developer.log('❌ Debug print failed: $e', name: 'StorageService');
      }
    }
  }
}
