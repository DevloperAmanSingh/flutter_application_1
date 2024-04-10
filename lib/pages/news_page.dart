import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/bookmarks_page.dart';
import 'package:flutter_application_1/pages/search_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/widgets/news_card.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<Map<String, dynamic>>> future;

  @override
  void initState() {
    super.initState();
    future = fetchNews(1, 10, 'topstories');
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Hacker News'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              icon: Icon(Icons.search),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Top Stories'),
              Tab(text: 'Best Stories'),
              Tab(text: 'New Stories'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(height: 100),
              ListTile(
                title: Text('Bookmarks'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookmarksPage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NewsList(fetchNews: fetchNews, category: 'topstories'),
            NewsList(fetchNews: fetchNews, category: 'beststories'),
            NewsList(fetchNews: fetchNews, category: 'newstories'),
          ],
        ),
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> Function(int, int, String) fetchNews;
  final String category;

  const NewsList({required this.fetchNews, required this.category});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchNews(0, 10, category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.red,
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount:
                  snapshot.data!.length > 10 ? 10 : snapshot.data!.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> data = snapshot.data![index];
                return NewsCard(
                  title: data['title'] ?? 'No Title',
                  author: data['author'] ?? 'Unknown Author',
                  points: data['points'] ?? 0,
                  comments: data['comments'] ?? 0,
                  url: data['url'] ?? '',
                  storyId: data['id'] ?? 0,
                );
              },
            );
          }
        },
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> fetchNews(
    int page, int pageSize, String category) async {
  final response = await http
      .get(Uri.parse('https://hacker-news.firebaseio.com/v0/$category.json'));
  if (response.statusCode == 200) {
    final List<dynamic> storyIds = jsonDecode(response.body);
    List<Map<String, dynamic>> stories = [];
    int startIndex = page * pageSize;
    int endIndex = (page + 1) * pageSize;
    endIndex = endIndex > storyIds.length ? storyIds.length : endIndex;
    for (var i = startIndex; i < endIndex; i++) {
      final storyResponse = await http.get(Uri.parse(
          'https://hacker-news.firebaseio.com/v0/item/${storyIds[i]}.json'));
      if (storyResponse.statusCode == 200) {
        final Map<String, dynamic> story = jsonDecode(storyResponse.body);
        if (story.containsKey('title') &&
            story.containsKey('by') &&
            story.containsKey('descendants')) {
          stories.add({
            'title': story['title'],
            'author': story['by'],
            'points': story['score'] ?? 0,
            'comments': story['descendants'] ?? 0,
            'url': story['url'] ?? '',
            'id': story['id'] ?? 0,
          });
        }
      }
    }
    return stories;
  } else {
    throw Exception('Failed to load news');
  }
}
