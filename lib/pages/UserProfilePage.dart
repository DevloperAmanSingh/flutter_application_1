import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProfilePage extends StatelessWidget {
  final String username;

  UserProfilePage({required this.username});

  Future<Map<String, dynamic>> fetchUserProfile(String username) async {
    final response = await http.get(
        Uri.parse('https://hacker-news.firebaseio.com/v0/user/$username.json'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile: $username'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchUserProfile(username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final userData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${userData['id']}'),
                  SizedBox(height: 8),
                  Text('Karma Points: ${userData['karma']}'),
                  SizedBox(height: 8),
                  Text(
                      'Creation Date: ${DateTime.fromMillisecondsSinceEpoch(userData['created'] * 1000)}'),
                  SizedBox(height: 8),
                  Text(
                      'Submitted: ${userData['submitted'].length} stories/comments'),
                  SizedBox(height: 8),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
