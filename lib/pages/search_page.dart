import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/WebFetch.dart';
import 'package:flutter_application_1/widgets/news_card_web.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class SearchResult {
  final String title;
  final String url;
  final String author;
  final int points;
  final int comments;

  SearchResult({
    required this.title,
    required this.url,
    required this.author,
    required this.points,
    required this.comments,
  });
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (value) {
                search(value);
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_searchResults[index].title),
                    subtitle: Text(
                      'Author: ${_searchResults[index].author}, Points: ${_searchResults[index].points}, Comments: ${_searchResults[index].comments}',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsWebView(url: _searchResults[index].url),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> search(String query) async {
    try {
      final results = await fetchSearchResults(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      // Handle error
      print('Error fetching search results: $e');
    }
  }

  Future<List<SearchResult>> fetchSearchResults(String query) async {
    final response = await http.get(
      Uri.parse('http://hn.algolia.com/api/v1/search?query=$query&tags=story'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<SearchResult> results = [];
      for (var hit in data['hits']) {
        results.add(SearchResult(
          title: hit['title'],
          url: hit['url'] ?? '',
          author: hit['author'] ?? '',
          points: hit['points'] ?? 0,
          comments: hit['num_comments'] ?? 0,
        ));
      }
      return results;
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
