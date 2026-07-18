import 'dart:convert';

import 'package:code_meter/utils/constraints.dart';
import 'package:code_meter/utils/result.dart';
import 'package:http/http.dart' as http;

Result<String, String> validateApiKeyLocal(String apiKey) {
  if (apiKey.isEmpty) {
    return Result<String, String>.err('API key cannot be empty');
  }
  if (!apiKey.startsWith("waka_")) {
    return Result<String, String>.err('Api key must start with "waka_"');
  }
  if (apiKey.length < 20) {
    return Result<String, String>.err(
      'Api key must be at least 20 characters long',
    );
  }
  if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(apiKey)) {
    return Result<String, String>.err(
      'Api key can only contain letters, numbers, and underscores',
    );
  }
  if (apiKey.length > 50) {
    return Result<String, String>.err(
      'Api key cannot be longer than 50 characters',
    );
  }
  return Result<String, String>.ok(apiKey);
}

Future<Result<String, String>> validateApiKeyRemote(String apiKey) async {
  if (apiKey.isEmpty) {
    return Result<String, String>.err('API key cannot be empty');
  }
  await Future.delayed(const Duration(seconds: 2));

  return Result<String, String>.err('API key cannot be empty');
  // return Result<String, String>.ok("Key Good");
}

Future<Result<int, String>> getTodaySeconds(String apiKey) async {
  try {
    final url = Uri.parse(Constraints.wakaTimeApiStatToday);
    final response = await http.get(
      url,
      headers: {'Authorization': 'Basic ${base64Encode(utf8.encode(apiKey))}'},
    );
    switch (response.statusCode) {
      case 200:
        return Ok(400);
      case 403:
        return Err("Permission denied to read stats");
      case 429:
        return Err("Too many requests, try again in a few seconds");
      case 500:
        return Err("Server failed, try again later.");

      case 404:
        return Err("404, something isn't right. update app or create a issue.");
      default:
        return Err('An  unexpected error occurred, try again later.');
    }
  } catch (e) {
    return Err('Network error: $e');
  }
}
