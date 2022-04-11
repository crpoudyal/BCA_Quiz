import 'package:bca_quiz/utils/colors.dart';
import 'package:bca_quiz/utils/utils.dart';
import 'package:bca_quiz/widgets/follow_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      print(userSnap.data());
      setState(() {
        userData = userSnap.data()!;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(userData.isEmpty);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(
          userData['username'] ?? '',
        ),
        centerTitle: false,
      ),
      body: userData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  color: mobileBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                userData['photoUrl'],
                              ),
                              radius: 40,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildStatColumn(followers, "Followers"),
                                      buildStatColumn(following, "Following"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FollowButton(
                                        text: "Edit profile",
                                        backgroundColor: mobileBackgroundColor,
                                        textColor: Colors.white,
                                        borderColor: Colors.grey,
                                        function: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            userData['bio'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    ListTile(
                      trailing: const IconButton(
                        icon: Icon(
                          Icons.edit_sharp,
                          color: mobileBackgroundColor,
                        ),
                        onPressed: null,
                      ),
                      textColor: mobileBackgroundColor,
                      title: const Text(
                        "Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(userData['username'] ?? ''),
                    ),
                    ListTile(
                      trailing: const IconButton(
                        icon: Icon(
                          Icons.edit_sharp,
                          color: mobileBackgroundColor,
                        ),
                        onPressed: null,
                      ),
                      textColor: mobileBackgroundColor,
                      title: const Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(userData['email'] ?? ''),
                    ),
                    ListTile(
                      trailing: const IconButton(
                        icon: Icon(
                          Icons.edit_sharp,
                          color: mobileBackgroundColor,
                        ),
                        onPressed: null,
                      ),
                      textColor: mobileBackgroundColor,
                      title: const Text(
                        "Biography",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(userData['bio'] ?? ''),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Column buildStatColumn(int numb, String label) {
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
