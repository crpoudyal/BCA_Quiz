import 'package:bca_quiz/screen/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Ranking",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .orderBy('score', descending: true)
                  .snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  final users = snapshot.data?.docs;
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              uid: (snapshot.data!).docs[index]['uid'],
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Card(
                            elevation: 10,
                            color: Colors.white,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  users?[index]['photoUrl'],
                                ),
                              ),
                              title: Text(
                                users?[index]['username'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(users?[index]['email'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                  )),
                              trailing: Text(
                                users![index]['score'].toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: users?.length,
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
