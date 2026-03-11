import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HuggingFaceService {
  // read the token from the .env file
  //final String apiKey = dotenv.env['HUGGING_FACE_TOKEN'] ?? '';
  final String apiKey = "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";
  // the model we want to query
  final String modelId = 'falan42/llama_lora_8b_medical_HealthcareMagictr2_gguf';

  Future<String> queryModel(String prompt) async {
    final url = Uri.parse('https://api-inference.huggingface.co/models/$modelId');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'inputs': prompt,
        'parameters': {'max_new_tokens': 100},
      }),
    );

    if (response.statusCode == 200) {
      final dynamic decoded = jsonDecode(response.body);
      if (decoded is List && decoded.isNotEmpty) {
        return decoded[0]['generated_text'] ?? '';
      } else if (decoded is Map && decoded.containsKey('error')) {
        throw Exception('Model error: ${decoded['error']}');
      } else {
        return '';
      }
    } else {
      throw Exception('Failed to reach Hugging Face: \n'
          'status=${response.statusCode} body=${response.body}');
    }
  }
}
