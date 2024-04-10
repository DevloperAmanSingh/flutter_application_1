import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsWebView extends StatefulWidget {
  String url;
  NewsWebView({super.key, required this.url});

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 232, 248, 215),
        title: const Text("Hacker News"),
      ),
    );
  }
}

Future<Map<String, dynamic>> fetchStoryDetails(int storyId) async {
  final response = await http.get(
      Uri.parse('https://hacker-news.firebaseio.com/v0/item/$storyId.json'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load story details');
  }
}
