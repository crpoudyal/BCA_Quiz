import 'package:bca_quiz/models/question.dart';
import 'package:bca_quiz/screen/quiz_screen.dart';
import 'package:bca_quiz/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../responsive/mobile_screen_layout.dart';

class ResultScreen extends StatefulWidget {
  final String subjectName;
  final List<Question> questions;
  final int totalTime;
  const ResultScreen({
    Key? key,
    required this.score,
    required this.questions,
    required this.totalTime,
    required this.subjectName,
  }) : super(key: key);

  final int score;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    _updateScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.subjectName),
            const SizedBox(height: 20),
            Text(
              'Result: ${widget.score} / ${widget.questions.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      totalTime: widget.totalTime,
                      questions: widget.questions,
                      subjectName: "",
                    ),
                  ),
                );
              },
              child: const Text("Play Again"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MobileScreenLayout(),
                  ),
                );
              },
              child: const Text("Go to Home"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _updateScore() async {
    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser != null) return;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(authUser!.uid);
    final userDoc = await userRef.get();

    if (userDoc.exists) {
      final user = userDoc.data()!;

      final lastScore = user['score'].get();

      userRef.update({'score': lastScore + widget.score});

      return;
    }
    userRef.set({
      'username': authUser.displayName,
      'email': authUser.email,
      'photoUrl': authUser.photoURL,
      'score': widget.score
    });
  }
}
