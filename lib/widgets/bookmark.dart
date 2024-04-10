import 'package:flutter/material.dart';

class Bookmark {
  static final Bookmark _instance = Bookmark._internal();

  factory Bookmark() {
    return _instance;
  }

  Bookmark._internal();

  final Set<int> _bookmarkedStories = {};

  Set<int> get bookmarkedStories => _bookmarkedStories;

  void toggleBookmark(int storyId) {
    if (_bookmarkedStories.contains(storyId)) {
      _bookmarkedStories.remove(storyId);
      print("Removed bookmark for story $storyId");
    } else {
      _bookmarkedStories.add(storyId);
      print("Added bookmark for story $storyId");
    }
  }

  bool isBookmarked(int storyId) {
    return _bookmarkedStories.contains(storyId);
  }
}
