import 'dart:convert';

import 'package:http/http.dart' as http;

class HuggingFaceService {
  // the model we want to query
  final String modelId = 'falan42/llama_lora_8b_medical_HealthcareMagictr2_gguf';

  Future<String> queryModel(String prompt) async {
    final url = Uri.parse('https://us-central1-llm-test-53375.cloudfunctions.net/queryHuggingFace');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'prompt': prompt,
      }),
    );

    if (response.statusCode == 200) {
      final dynamic decoded = jsonDecode(response.body);
      return decoded['generated_text'] ?? '';
    } else {
      throw Exception('Failed to reach Cloud Function: \n'
          'status=${response.statusCode} body=${response.body}');
    }
  }
}
