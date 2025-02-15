import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@singleton
@Injectable()
class OpenAIService {
  final http.Client client;

  final apiKey = '';  

  OpenAIService({required this.client});

  Future<List<double>> generateEmbedding(String query) async {
    final response = await client.post(
      Uri.parse('https://api.openai.com/v1/embeddings'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "input": query,
        "model": "text-embedding-ada-002",
        "encoding_format": "float",
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data);
      return List<double>.from(data['data'][0]['embedding']);
    } else {
      print(response.statusCode);
      throw Exception('Failed to generate embedding');
    }
  }
}
