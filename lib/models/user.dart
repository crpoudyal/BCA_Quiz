import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String photoUrl;
  final String uid;
  final String bio;
  final List followers;
  final List following;
  final int score;

  const User(
      {required this.email,
      required this.username,
      required this.photoUrl,
      required this.uid,
      required this.bio,
      required this.followers,
      required this.following,
      required this.score});

  factory User.fromjson(Map<dynamic, dynamic> json) {
    return User(
        email: json['email'],
        username: json['username'],
        photoUrl: json['photoUrl'],
        uid: json['uid'],
        bio: json['bio'],
        followers: json['followers'],
        following: json['following'],
        score: json['score']);
  }
  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'photoUrl': photoUrl,
        'bio': bio,
        'followers': [],
        'following': [],
        'score': score
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<dynamic, dynamic>;
    return User(
        email: snapshot['email'],
        username: snapshot['username'],
        photoUrl: snapshot['photoUrl'],
        uid: snapshot['uid'],
        bio: snapshot['bio'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        score: snapshot['score']);
  }
}
