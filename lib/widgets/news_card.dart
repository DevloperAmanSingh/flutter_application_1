import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/WebFetch.dart';
import 'package:flutter_application_1/pages/UserProfilePage.dart';
import 'package:flutter_application_1/widgets/bookmark.dart';

class NewsCard extends StatefulWidget {
  final String title;
  final int storyId;
  final String author;
  final int points;
  final int comments;
  final String url;

  NewsCard({
    required this.title,
    required this.author,
    required this.points,
    required this.comments,
    required this.url,
    required this.storyId,
  });

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserProfilePage(username: widget.author),
                  ),
                );
              },
              child: Text(
                'Author: ${widget.author}',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsWebView(url: widget.url),
                      ),
                    );
                  },
                  child: const Text(
                    'Read More',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Row(
                  children: <Widget>[
                    const Icon(Icons.thumb_up),
                    const SizedBox(width: 6),
                    Text('${widget.points}'),
                    const SizedBox(width: 20),
                    const Icon(Icons.comment),
                    const SizedBox(width: 4),
                    Text('${widget.comments}'),
                    IconButton(
                      icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      ),
                      onPressed: () {
                        setState(() {
                          isBookmarked = !isBookmarked;
                        });
                        if (isBookmarked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Bookmarked'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Removed from Bookmarks'),
                            ),
                          );
                        }
                        print("Bookmark Toggled");
                        print(widget.storyId);
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
