import 'package:bca_quiz/models/subject.dart';
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
  List<Subject> secSemester = [];

  @override
  void initState() {
    super.initState();
    print("Initstate -----------");
    getData();
  }

  getData() async {
    try {
      var courseSnap =
          await FirebaseFirestore.instance.collection('subject').snapshots();
      print("DATA-----");
      courseSnap.forEach((element) {
        element.docs.forEach((element) {
          print(element.data());

          setState(() {
            subject.add(Subject.fromSnap(element));
            secSemester =
                subject.where((element) => element.semester == 2).toList();
          });
          print(secSemester.length);
        });
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sixth sem"),
      ),
      body: secSemester.isEmpty
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: secSemester.length,
              itemBuilder: (context, index) => Column(
                children: [
                  InkWell(
                    onTap: null,
                    child: ListTile(
                      textColor: mobileBackgroundColor,
                      title: Text(
                        secSemester[index].sub_name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(secSemester[index].sub_code),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
