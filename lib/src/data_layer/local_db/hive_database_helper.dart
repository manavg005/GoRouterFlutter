import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../business_layer/helpers/log_helper.dart';

class HiveHelper {
  static initializeHiveAndRegisterAdapters() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbFilePath = [appDocDir.path, 'keyPitKleen_db'].join('/');
    Hive.init(dbFilePath);
  }

  close() {
    Hive.close();
  }
}

class SecureStorageHelper {
  SecureStorageHelper.__internal();

  static final SecureStorageHelper _instance = SecureStorageHelper.__internal();

  static SecureStorageHelper get instance => _instance;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final String _secureKey = 'secure_key';

  String? encryptionKey;
  List<int> decodedKey = [];

  /// Method used to secure decoded key for encrypting the box [Boxes.userBox]
  Future<void> generateEncryptionKey() async {
    try {
      /// Decrypts and returns the value for the given key or null if key is not
      /// in the storage
      encryptionKey = await secureStorage.read(key: _secureKey);
      if (encryptionKey == null) {
        /// Generates a secure encryption key using the fortuna random algorithm
        final key = Hive.generateSecureKey();

        /// Encrypts and saves the key with the given value.
        /// If the key was already in the storage, its associated value is changed.
        /// If the value is null, deletes associated value for the given key.
        /// key shouldn't be null
        await secureStorage.write(
          key: _secureKey,
          value: base64UrlEncode(key),
        );

        /// Decrypts and returns the value for the given key
        encryptionKey = await secureStorage.read(key: _secureKey);
      }
      // /The input is decoded as if by [decoder.convert]
      decodedKey = base64Url.decode(encryptionKey!);
      LogHelper.logData('Encryption key: ========> $decodedKey');
    } catch (e) {
      LogHelper.logError("Secure Storage Exception: ========> $e");
    }
  }

  Future<void> setAccessToken(String? accessToken) async {
    await secureStorage.write(key: Boxes.accessToken, value: accessToken);
  }

  Future<void> deleteAccessToken() async {
    await secureStorage.delete(key: Boxes.accessToken);
  }

  Future<String?> getAccessToken() async {
    final accessToken = await secureStorage.read(key: Boxes.accessToken);
    return accessToken ?? "";
  }
}

class Boxes {
  static const String userBox = 'userBox';
  static const String accessToken = 'access_token';
  static const String userId = 'user_id';
  static const String isUserLoggedIn = 'isUserLoggedIn';
  static const String isOnboardingDone = 'isOnboardingDone';
  static const String isSocialLogin = 'isSocialLogin';
  static const String userAddress = 'user_address_model';
}

class HiveTypes {
  static const int user = 0;
}
