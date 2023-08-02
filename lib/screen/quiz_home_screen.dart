import 'dart:developer';

import 'package:bca_quiz/responsive/mobile_screen_layout.dart';
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data == null || snapshot.hasError) {
                      return const Center(
                        child: Text('Error fetching data'),
                      );
                    }

                    final questionDocs = snapshot.data!.docs;

                    final questions = questionDocs
                        .map((e) => Question.fromQueryDocumentSnapshot(e))
                        .where((element) =>
                            element.subject.contains(widget.subName))
                        .toList();

                    log("Question $questions");
                    return Column(
                      children: [
                        SizedBox(
                          width: 150,
                          child: questions.isEmpty
                              ? ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MobileScreenLayout(),
                                      ),
                                    );
                                  },
                                  child: const Text("Go to Home"),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuizScreen(
                                          totalTime: 50,
                                          questions: questions,
                                          subjectName: widget.subName,
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
