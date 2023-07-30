import 'dart:developer';

import 'package:bca_quiz/resources/auth_method.dart';
import 'package:bca_quiz/resources/firestore_methods.dart';
import 'package:bca_quiz/screen/editprofile_screeen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bca_quiz/screen/login_screen.dart';
import 'package:bca_quiz/utils/colors.dart';
import 'package:bca_quiz/utils/utils.dart';
import 'package:bca_quiz/widgets/follow_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userData = {};
  int followers = 0;
  int following = 0;
  int ranking = 0;
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      log(userSnap.data().toString());
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        userData = userSnap.data()!;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    log(userData.isEmpty.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(userData['username'] ?? ''),
        backgroundColor: mobileBackgroundColor,
      ),
      body: userData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  color: mobileBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            userData['photoUrl'] ?? '',
                          ),
                          radius: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            userData['email'] ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FirebaseAuth.instance.currentUser!.uid ==
                                        widget.uid
                                    ? FollowButton(
                                        text: "Edit Profile",
                                        backgroundColor: mobileBackgroundColor,
                                        textColor: Colors.white,
                                        borderColor: Colors.grey,
                                        function: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      EditProfileScreen())));
                                        },
                                      )
                                    : isFollowing
                                        ? FollowButton(
                                            text: "Unfollow",
                                            backgroundColor: Colors.white,
                                            textColor: Colors.black,
                                            borderColor: Colors.grey,
                                            function: () async {
                                              await FirestoreMethods()
                                                  .followUser(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                userData['uid'],
                                              );
                                              setState(() {
                                                isFollowing = false;
                                                followers--;
                                              });
                                            },
                                          )
                                        : FollowButton(
                                            text: "Follow",
                                            backgroundColor: Colors.blue,
                                            textColor: Colors.white,
                                            borderColor: Colors.blue,
                                            function: () async {
                                              await FirestoreMethods()
                                                  .followUser(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                userData['uid'],
                                              );
                                              setState(() {
                                                isFollowing = true;
                                                followers++;
                                              });
                                            },
                                          )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildStatColumn(followers, "Followers"),
                                  buildStatColumn(following, "Following"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 12),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      "I am " + userData['bio'],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await AuthMethods().signOut();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.logout),
        label: const Text("Sign out"),
      ),
    );
  }

  Widget buildStatColumn(int numb, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          numb.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label.toString(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
