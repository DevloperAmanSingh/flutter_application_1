import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bookmark extends ChangeNotifier {
  final Set<int> _bookmarkedStories = {};

  Set<int> get bookmarkedStories => _bookmarkedStories;

  Future<void> toggleBookmark(int storyId) async {
    if (_bookmarkedStories.contains(storyId)) {
      _bookmarkedStories.remove(storyId);
      notifyListeners();
    } else {
      _bookmarkedStories.add(storyId);
      notifyListeners();
    }
    await _saveBookmarks();
  }

  bool isBookmarked(int storyId) {
    return _bookmarkedStories.contains(storyId);
  }

  Future<void> _saveBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('bookmarkedStories',
        _bookmarkedStories.map((id) => id.toString()).toList());
  }

  Future<void> loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookmarkedIds = prefs.getStringList('bookmarkedStories');
    if (bookmarkedIds != null) {
      _bookmarkedStories.addAll(bookmarkedIds.map((id) => int.parse(id)));
    }
    notifyListeners();
  }
}
