import 'package:flutter/material.dart';

class QuizHomeScreen extends StatefulWidget {
  const QuizHomeScreen({Key? key}) : super(key: key);

  @override
  State<QuizHomeScreen> createState() => _QuizHomeScreenState();
}

class _QuizHomeScreenState extends State<QuizHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/BCAquiz.png"),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Lets Play"),
          )
        ],
      ),
    );
  }
}
