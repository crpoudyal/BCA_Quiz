import 'package:flutter/material.dart';

class User {
  final String email;
  final String username;
  final String photoUrl;
  final String uid;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.username,
    required this.photoUrl,
    required this.uid,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'photoUrl': photoUrl,
        'bio': bio,
        'followers': [],
        'following': [],
      };
}
