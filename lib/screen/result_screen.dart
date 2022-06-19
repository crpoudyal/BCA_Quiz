import 'package:bca_quiz/models/question.dart';
import 'package:bca_quiz/screen/quiz_screen.dart';
import 'package:bca_quiz/utils/colors.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    Key? key,
    required this.score,
    required this.questions,
    required this.totalTime,
  }) : super(key: key);

  final int score;
  final List<Question> questions;
  final int totalTime;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    ),
                  ),
                );
              },
              child: const Text("Play Again"),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
