import 'package:bca_quiz/screen/course_screen.dart';
import 'package:bca_quiz/screen/quiz_home_screen.dart';
import 'package:bca_quiz/utils/colors.dart';
import 'package:bca_quiz/widgets/sem_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.onTap}) : super(key: key);
  final Function? onTap;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("BCA Hub"),
        leading: Image.asset(
          'assets/images/BCAquiz.png',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 150,
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_box,
                        size: 12,
                        color: Color(0xFF50DDF6),
                      ),
                      Text(
                        " Quiz's at any time anywhere",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuizHomeScreen()));
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                      child: Text(
                        'Play Now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                children: [
                  semContainer("First", Colors.blueAccent, Icons.code, () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CourseScreen(
                                  sid: '',
                                )));
                  }),
                  semContainer("Second", Colors.redAccent, Icons.code, () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CourseScreen(
                                  sid: '',
                                )));
                  }),
                  semContainer("Third", Colors.greenAccent, Icons.code, () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CourseScreen(
                                  sid: '',
                                )));
                  }),
                  semContainer("Fourth", Colors.blueGrey, Icons.code, () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CourseScreen(
                                  sid: '',
                                )));
                  }),
                  semContainer("Fifth", Colors.purpleAccent, Icons.code, () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CourseScreen(
                                  sid: '',
                                )));
                  }),
                  semContainer("Sixth", Colors.cyan, Icons.code, () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CourseScreen(
                                  sid: '',
                                )));
                  }),
                  semContainer("Seventh", Colors.deepOrangeAccent, Icons.code,
                      () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CourseScreen(
                                  sid: '',
                                )));
                  }),
                  semContainer("Eighth", Colors.brown, Icons.code, () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CourseScreen(
                                  sid: '',
                                )));
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
