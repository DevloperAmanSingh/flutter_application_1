import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/WebFetch.dart';
import 'package:flutter_application_1/widgets/bookmark.dart';
import 'package:flutter_application_1/widgets/news_card.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final Bookmark _bookmark = Bookmark();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: ListView.builder(
        itemCount: _bookmark.bookmarkedStories.length,
        itemBuilder: (context, index) {
          final storyId = _bookmark.bookmarkedStories.elementAt(index);
          return FutureBuilder<Map<String, dynamic>>(
            future: fetchStoryDetails(storyId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final bookmark = snapshot.data!;
                return NewsCard(
                  title: bookmark['title'] ?? 'No Title',
                  author: bookmark['by'] ?? 'Unknown Author',
                  points: bookmark['score'] ?? 0,
                  comments: bookmark['descendants'] ?? 0,
                  url: bookmark['url'] ?? '',
                  storyId: bookmark['id'] ?? 0,
                );
              }
            },
          );
        },
      ),
    );
  }
}
