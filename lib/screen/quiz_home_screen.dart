import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:bca_quiz/models/question.dart';
import 'package:bca_quiz/screen/quiz_screen.dart';
import 'package:bca_quiz/utils/colors.dart';

class QuizHomeScreen extends StatefulWidget {
  String subName;
  QuizHomeScreen({
    Key? key,
    required this.subName,
  }) : super(key: key);

  @override
  State<QuizHomeScreen> createState() => _QuizHomeScreenState();
}

class _QuizHomeScreenState extends State<QuizHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/BCAquiz.png",
                  height: 150,
                  width: 150,
                ),
                Text(widget.subName),
                const SizedBox(
                  height: 40,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("questions")
                      .snapshots(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final questionDocs = snapshot.data!.docs;

                    final questions = questionDocs
                        .map((e) => Question.fromQueryDocumentSnapshot(e))
                        .toList()
                        .where(
                      (element) {
                        return element.subject.contains(widget.subName);
                      },
                    ).toList();
                    return Column(
                      children: [
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizScreen(
                                    totalTime: 50,
                                    questions: questions,
                                  ),
                                ),
                              );
                            },
                            child: const Text("Lets Play"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text("Total Question : ${questions.length}"),
                      ],
                    );
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
