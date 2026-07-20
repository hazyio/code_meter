import 'dart:convert';

// import 'package:code_meter/i18n/app_localizations.dart';
import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/utils/constraints.dart';
import 'package:code_meter/utils/result.dart';
import 'package:http/http.dart' as http;

Result<String, String> validateApiKeyLocal(
  String apiKey,
  // AppLocalizations translation,
) {
  final translation = t.api.validation;
  if (apiKey.isEmpty) {
    return Result<String, String>.err(translation.cannotBeEmpty);
  }
  if (!apiKey.startsWith("waka_")) {
    return Result<String, String>.err(translation.mustStartWithWaka);
  }
  if (apiKey.length < 20) {
    return Result<String, String>.err(translation.atLeast20Characters);
  }
  if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(apiKey)) {
    return Result<String, String>.err(translation.inValid);
  }
  if (apiKey.length > 50) {
    return Result<String, String>.err(translation.atMost50Characters);
  }
  return Result<String, String>.ok(apiKey);
}

Future<Result<String, String>> validateApiKeyRemote(String apiKey) async {
  final translation = t.api;
  if (apiKey.isEmpty) {
    return Result<String, String>.err(translation.validation.cannotBeEmpty);
  }
  final result = await getTodaySeconds(apiKey);
  switch (result) {
    case Ok<int, String>():
      return Result<String, String>.ok("Correct");
    case Err<int, String>(error: final e):
      return Result<String, String>.err(e);
  }
}

Future<Result<int, String>> getTodaySeconds(String apiKey) async {
  final translation = t.api.responses;
  try {
    final url = Uri.parse(Constraints.wakaTimeApiStatToday);
    final response = await http.get(
      url,
      headers: {'Authorization': 'Basic ${base64Encode(utf8.encode(apiKey))}'},
    );
    switch (response.statusCode) {
      case 200:
        return Ok(400);
      case 401:
        return Err(translation.unAuthorized);
      case 400:
        return Err(translation.badRequest);
      case 403:
        return Err(translation.permissionDenied);
      case 429:
        return Err(translation.tooManyRequests);
      case 500:
        return Err(translation.serverFailed);

      case 404:
        return Err(translation.notFoundError);
      default:
        return Err(t.unExpectedError);
    }
  } catch (e) {
    return Err(translation.networkError(error: e));
  }
}
