import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../app_settings.dart';
import 'hive_database_helper.dart';

/// Helper class to save user information locally on the device
class UserStateHiveHelper {
  UserStateHiveHelper.__internal();

  static final UserStateHiveHelper _instance = UserStateHiveHelper.__internal();

  static UserStateHiveHelper get instance => _instance;

  /// Method to open user box [Boxes.userBox]
  /// Box is opened only when hive is initialized
  /// Hive already initialized in [main.dart] file
  /// inside main method before runApp method is called
  Future<dynamic> _open() async {
    try {
      return await Hive.openBox(
        Boxes.userBox,
        encryptionCipher:
            HiveAesCipher(SecureStorageHelper.instance.decodedKey),
      );
    } catch (e) {
      /// If hive db gives some error then it is initialized and open again
      /// and generate again encryption key for encrypted hive box
      // await HiveHelper.initializeHiveAndRegisterAdapters();
      await SecureStorageHelper.instance.generateEncryptionKey();
      return await Hive.openBox(
        Boxes.userBox,
        encryptionCipher:
            HiveAesCipher(SecureStorageHelper.instance.decodedKey),
      );
    }
  }

  void close() async {
    await _open().then((box) {
      box.close();
    });
  }

  Future<void> setAccessToken(String accessToken) async {
    await SecureStorageHelper.instance.setAccessToken(accessToken);
  }

  Future<String> getAccessToken() async {
    final accessToken = await SecureStorageHelper.instance.getAccessToken();
    return accessToken ?? "";
  }

  Future<void> setIsUserLoggedIn(bool isUserLoggedIn) async {
    final Box<dynamic> encryptedBox = await _open();
    await encryptedBox.put(Boxes.isUserLoggedIn, isUserLoggedIn);
  }

  Future<bool> getIsUserLoggedIn() async {
    final Box<dynamic> encryptedBox = await _open();
    final isUserLoggedIn =
        await encryptedBox.get(Boxes.isUserLoggedIn, defaultValue: false);
    return isUserLoggedIn;
  }

  Future<void> clearData() async {
    final Box<dynamic> encryptedBox = await _open();
    await encryptedBox.clear();
    await SecureStorageHelper.instance.deleteAccessToken();
  }

  Future<int> getUserId() async {
    final Box<dynamic> encryptedBox = await _open();
    final userId = await encryptedBox.get(Boxes.userId, defaultValue: 0);
    return userId;
  }

  Future<void> printAll() async {
    final Box<dynamic> encryptedBox = await _open();
    encryptedBox.toMap().forEach((key, value) {
      if (AppSettings.disableLogs) return;
      debugPrint("Key: $key, Value: $value");
    });
  }

  Future<void> setIsOnboardingCompleted(bool isOnboardingDone) async {
    final Box<dynamic> encryptedBox = await _open();
    await encryptedBox.put(Boxes.isOnboardingDone, isOnboardingDone);
  }

  Future<bool> getIsOnboardingCompleted() async {
    final Box<dynamic> encryptedBox = await _open();
    final isOnboardingDone =
        await encryptedBox.get(Boxes.isOnboardingDone, defaultValue: false);
    return isOnboardingDone;
  }

  Future<void> setIsSocialLogin(bool isSocialLogin) async {
    final Box<dynamic> encryptedBox = await _open();
    await encryptedBox.put(Boxes.isSocialLogin, isSocialLogin);
  }

  Future<bool> getIsSocialLogin() async {
    final Box<dynamic> encryptedBox = await _open();
    final isSocialLogin =
        await encryptedBox.get(Boxes.isSocialLogin, defaultValue: false);
    return isSocialLogin;
  }

  Future<String> getUserDetails() async {
    final Box<dynamic> encryptedBox = await _open();
    final userDetails = await encryptedBox.get(Boxes.userDetails);
    return userDetails;
  }

  Future<void> setUserDetails(String? userDetails) async {
    final Box<dynamic> encryptedBox = await _open();
    await encryptedBox.put(Boxes.userDetails, userDetails);
  }

  ///
  Future<void> setUserName(String? userName) async {
    final Box<dynamic> encryptedBox = await _open();
    await encryptedBox.put(Boxes.userName, userName);
  }

  Future<void> setUserEmail(String? userEmail) async {
    final Box<dynamic> encryptedBox = await _open();
    await encryptedBox.put(Boxes.userEmail, userEmail);
  }
  Future<void> setUserPhoneNo(String? userPhone) async {
    final Box<dynamic> encryptedBox = await _open();
    await encryptedBox.put(Boxes.userPhone, userPhone);
  }

  Future<String> getUserName() async {
    final Box<dynamic> encryptedBox = await _open();
    final userDetails =
    await encryptedBox.get(Boxes.userName);
    return userDetails;
  }
  Future<String> getUserEmail() async {
    final Box<dynamic> encryptedBox = await _open();
    final userDetails =
    await encryptedBox.get(Boxes.userEmail);
    return userDetails;
  }
  Future<String> getUserPhone() async {
    final Box<dynamic> encryptedBox = await _open();
    final userDetails =
    await encryptedBox.get(Boxes.userPhone);
    return userDetails;
  }
}
