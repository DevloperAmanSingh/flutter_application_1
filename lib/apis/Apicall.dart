import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchStoryDetails(int storyId) async {
  final response = await http.get(
      Uri.parse('https://hacker-news.firebaseio.com/v0/item/$storyId.json'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load story details');
  }
}
