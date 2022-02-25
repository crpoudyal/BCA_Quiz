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
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 140,
            color: mobileBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Prepare For Your Exam',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.check_box,
                        size: 12,
                        color: Color(0xFF50DDF6),
                      ),
                      Text(
                        " Quizes at any time anywhere",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.check_box,
                        size: 12,
                        color: Color(0xFF50DDF6),
                      ),
                      Text(
                        " MCQ for all semester",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                      child: Text(
                        'Play Now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Semester",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
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
