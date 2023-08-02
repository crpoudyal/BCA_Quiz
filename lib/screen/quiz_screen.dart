import 'dart:async';

import 'package:bca_quiz/models/question.dart';
import 'package:bca_quiz/screen/result_screen.dart';
import 'package:bca_quiz/utils/colors.dart';
import 'package:bca_quiz/widgets/answer_tile.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen(
      {Key? key,
      required this.totalTime,
      required this.questions,
      required this.subjectName})
      : super(key: key);
  final int totalTime;
  final String subjectName;
  final List<Question> questions;
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late int _currentTime;
  late Timer _timer;
  int _currentIndex = 0;
  String _selectedAnswer = "";
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _currentTime = widget.totalTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _currentTime - 1;
      });
      if (_currentTime == 0) {
        _timer.cancel();
        pushResultScreen(context);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[_currentIndex];
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.subjectName,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: _currentTime / widget.totalTime,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Question"),
              const SizedBox(
                height: 20,
              ),
              Text(
                currentQuestion.question,
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: currentQuestion.answers.length,
                    itemBuilder: ((context, index) {
                      final answer = currentQuestion.answers[index];
                      return AnswerTile(
                        isSelected: answer == _selectedAnswer,
                        answer: answer,
                        correctAnswer: currentQuestion.correctAnswer,
                        onTap: () {
                          setState(() {
                            _selectedAnswer = answer;
                          });
                          if (answer == currentQuestion.correctAnswer) {
                            _score++;
                          }
                          Future.delayed(const Duration(milliseconds: 200), () {
                            if (_currentIndex == widget.questions.length - 1) {
                              pushResultScreen(context);
                              return;
                            }
                            setState(() {
                              _currentIndex++;
                              _selectedAnswer = '';
                            });
                          });
                        },
                      );
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pushResultScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          questions: widget.questions,
          totalTime: widget.totalTime,
          subjectName: widget.subjectName,
          score: _score,
        ),
      ),
    );
  }
}
