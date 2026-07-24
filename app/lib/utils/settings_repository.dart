import 'dart:developer' as developer show log;

import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/utils/api.dart';
import 'package:code_meter/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const _keyRewardPercentage = 'reward_percentage';
  static const _keyAllowRollover = 'allow_rollover';
  static const _apiKeyStorageKey = 'wakatime_api_key';

  final _secureStorage = const FlutterSecureStorage();
  Future<bool> clearAll() async {
    try {
      await _secureStorage.deleteAll();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return true;
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          'Failed to clear all data',
          name: 'CodeMeter.SettingsRepository',
          error: e,
        );
      }
      return false;
    }
  }

  Future<bool> saveApiKey(String apiKey) async {
    try {
      await _secureStorage.write(key: _apiKeyStorageKey, value: apiKey);
      return true;
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          'Failed to save Api Key',
          name: 'CodeMeter.SettingsRepository',
          error: e,
        );
      }
      return false;
    }
  }

  Future<String?> getApiKey() async {
    try {
      return await _secureStorage.read(key: _apiKeyStorageKey);
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          'Failed to get Api Key',
          name: 'CodeMeter.SettingsRepository',
          error: e,
        );
      }
      return null;
    }
  }

  Future<bool> saveRewardPercentage(int value) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setInt(_keyRewardPercentage, value);
      return true;
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          'Failed to save Reward Percent',
          name: 'CodeMeter.SettingsRepository',
          error: e,
        );
      }
      return false;
    }
  }

  Future<int?> getRewardPercentage() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getInt(_keyRewardPercentage);
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          'Failed to get Reward Percent',
          name: 'CodeMeter.SettingsRepository',
          error: e,
        );
      }
      return null;
    }
  }

  Future<bool> saveAllowRollover(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setBool(_keyAllowRollover, value);
      return true;
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          'Failed to save allowRollover',
          name: 'CodeMeter.SettingsRepository',
          error: e,
        );
      }
      return false;
    }
  }

  Future<bool?> getAllowRollover() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getBool(_keyAllowRollover);
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          'Failed to get allowRollover',
          name: 'CodeMeter.SettingsRepository',
          error: e,
        );
      }
      return null;
    }
  }
}

class SettingsStorage {
  String apiKey;
  int rewardPercent;
  bool allowRollover;
  SettingsStorage({
    required this.apiKey,
    required this.rewardPercent,
    required this.allowRollover,
  });
  Future<Result<String, String>> save() async {
    final translation = t.storage;
    final repo = SettingsRepository();
    if (!await repo.saveApiKey(apiKey)) {
      return Result<String, String>.err(translation.failedToSaveApiKey);
    }
    if (!await repo.saveAllowRollover(allowRollover)) {
      return Result<String, String>.err(translation.failedToSaveApiKey);
    }
    if (!await repo.saveRewardPercentage(rewardPercent)) {
      return Result<String, String>.err(translation.failedToSaveApiKey);
    }
    return Result<String, String>.ok("ok");
  }

  static Future<bool> settingSaved() async {
    final apiKey = await SettingsRepository().getApiKey();
    if (apiKey == null) return false;
    switch (validateApiKeyLocal(apiKey)) {
      case Ok():
        return true;
      case Err():
        return false;
    }
  }

  static Future<Result<SettingsStorage, String>> retrieve(
    String apiKey,
    int rewardPercent,
    bool allowRollover,
  ) async {
    final translation = t.storage;
    final repo = SettingsRepository();
    var settingsStorage = SettingsStorage(
      apiKey: '',
      rewardPercent: 0,
      allowRollover: false,
    );
    var apiValue = await repo.getApiKey();
    if (apiValue == null) {
      return Result<SettingsStorage, String>.err(translation.failedToGetApiKey);
    } else {
      settingsStorage.apiKey = apiValue;
    }
    var rolloverValue = await repo.getAllowRollover();
    if (rolloverValue == null) {
      return Result<SettingsStorage, String>.err(
        translation.failedToGetRollover,
      );
    } else {
      settingsStorage.allowRollover = rolloverValue;
    }
    var rewardValue = await repo.getRewardPercentage();
    if (rewardValue == null) {
      return Result<SettingsStorage, String>.err(translation.failedToGetReward);
    } else {
      settingsStorage.rewardPercent = rewardValue;
    }

    return Result<SettingsStorage, String>.ok(settingsStorage);
  }
}
