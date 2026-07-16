import 'package:code_meter/utils/result.dart';

Result<String, String> validateApiKey(String apiKey) {
  if (apiKey.isEmpty) {
    return Err('API key cannot be empty');
  }
  if (!apiKey.startsWith("waka_")) {
    return Err('Api key must start with "waka_"');
  }
  if (apiKey.length < 20) {
    return Err('Api key must be at least 20 characters long');
  }
  if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(apiKey)) {
    return Err('Api key can only contain letters, numbers, and underscores');
  }
  if (apiKey.length > 50) {
    return Err('Api key cannot be longer than 50 characters');
  }
  return Ok(apiKey);
}
