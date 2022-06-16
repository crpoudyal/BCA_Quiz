import 'package:bca_quiz/models/subject.dart';
import 'package:bca_quiz/screen/home_screen.dart';
import 'package:bca_quiz/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class CourseScreen extends StatefulWidget {
  final String sid;
  const CourseScreen({Key? key, required this.sid}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  Map<dynamic, dynamic> courseData = {};

  List<Subject> subject = [];
  List<Subject> semester = [];
  int currentIndex = 1;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    try {
      var courseSnap =
          FirebaseFirestore.instance.collection('subject').snapshots();

      courseSnap.forEach((element) {
        for (var element in element.docs) {
          setState(() {
            subject.add(Subject.fromSnap(element));
            semester = subject
                .where((element) => element.semester == currentIndex)
                .toList();
          });
        }
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text("Courses"),
          centerTitle: true,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                currentIndex = index + 1;
              });
            },
            tabs: const [
              Tab(
                text: '1',
              ),
              Tab(
                text: '2',
              ),
              Tab(
                text: '3',
              ),
              Tab(
                text: '4',
              ),
              Tab(
                text: '5',
              ),
              Tab(
                text: '6',
              ),
              Tab(
                text: '7',
              ),
              Tab(
                text: '8',
              ),
            ],
          ),
        ),
        body: semester.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: semester.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: ListTile(
                        textColor: mobileBackgroundColor,
                        title: Text(
                          semester[index].sub_name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(semester[index].sub_code),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
