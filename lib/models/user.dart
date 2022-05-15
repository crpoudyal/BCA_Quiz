import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory User.fromjson(Map<dynamic, dynamic> json) {
    return User(
      email: json['email'],
      username: json['username'],
      photoUrl: json['photoUrl'],
      uid: json['uid'],
      bio: json['bio'],
      followers: json['followers'],
      following: json['following'],
    );
  }
  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'photoUrl': photoUrl,
        'bio': bio,
        'followers': [],
        'following': [],
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
        following: snapshot['following']);
  }
}
