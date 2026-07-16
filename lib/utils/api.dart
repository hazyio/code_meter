import 'package:code_meter/utils/result.dart';

Result<String, String> validateApiKey(String apiKey) {
  if (apiKey.isEmpty) {
    return Err('API key cannot be empty');
  }
  // Add more validation logic if needed
  return Ok(apiKey);
}
