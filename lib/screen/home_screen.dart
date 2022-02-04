import 'package:bca_quiz/utils/colors.dart';
import 'package:bca_quiz/widgets/sem_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Image.asset(
          'assets/images/BCAquiz.png',
          height: 64,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              children: [
                semContainer("First", Colors.blueAccent, Icons.code),
                semContainer("Second", Colors.redAccent, Icons.code),
                semContainer("Third", Colors.greenAccent, Icons.code),
                semContainer("Fourth", Colors.blueGrey, Icons.code),
                semContainer("Fifth", Colors.purpleAccent, Icons.code),
                semContainer("Sixth", Colors.cyan, Icons.code),
                semContainer("Seventh", Colors.deepOrangeAccent, Icons.code),
                semContainer("Eighth", Colors.brown, Icons.code),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
