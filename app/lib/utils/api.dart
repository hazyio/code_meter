import 'dart:convert';
import 'dart:developer' as developer;

// import 'package:code_meter/i18n/app_localizations.dart';
import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/utils/constraints.dart';
import 'package:code_meter/utils/result.dart';
import 'package:flutter/foundation.dart';
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
    final response = await makeRequest(
      Constraints.wakaTimeApiStatToday,
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
        return Err(t.labels.unExpectedError);
    }
  } catch (e) {
    return Err(translation.networkError(error: e));
  }
}

Future<Result<List<Map<String, String>>, String>> getAllowedApps() async {
  final translation = t.api;
  final data = await fetchEssentialApps();
  if (data == null) {
    return Err(translation.responses.filedToGetAllowedApps);
  }
  return Ok(
    data
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .map((line) {
          final parts = line.split(',');
          if (parts.length < 2) return <String, String>{};

          return <String, String>{'app_id': parts[0], 'app_url': parts[1]};
        })
        .where((item) => item.isNotEmpty)
        .toList(),
  );
}

Future<http.Response> makeRequest(
  String url, {
  Map<String, String> headers = const {},
  int timeout = 8,
}) async {
  if (kDebugMode) {
    developer.log('Fetching from $url, headers: $headers, timeout: $timeout');
  }
  return await http
      .get(Uri.parse(url), headers: headers)
      .timeout(Duration(seconds: timeout));
}

List<String> buildSources(String path) {
  return [
    'https://codemeter.hazyio.com$path',
    "https://cdn.statically.io/gh/hazyio/code_meter@main/site/static$path",
    'https://raw.githubusercontent.com/hazyio/code_meter/main/site/static$path',
  ];
}

Future<String?> fetchEssentialApps() async {
  final sources = buildSources("/essential_apps.txt");
  for (final url in sources) {
    try {
      if (kDebugMode) {
        developer.log('Fetching essential apps list from $url');
      }
      final response = await makeRequest(url);

      if (response.statusCode == 200) return response.body;
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          'url $url failed',
          name: 'CodeMeter.fetchEssentialApps',
          error: e,
        );
      }

      continue; // try the next source
    }
  }
  return null;
}

Future<String?> fetchLatestAppVersion() async {
  final sources = buildSources("/app_version.txt");
  for (final url in sources) {
    try {
      if (kDebugMode) {
        developer.log('Fetching latest app version from $url');
      }
      final response = await makeRequest(url);

      if (response.statusCode == 200) return response.body;
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          'url $url failed',
          name: 'CodeMeter.fetchLatestAppVersion',
          error: e,
        );
      }

      continue; // try the next source
    }
  }
  return null;
}
