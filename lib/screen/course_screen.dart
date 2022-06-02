import 'dart:developer';

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
  List<Subject> semester = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var courseSnap =
          FirebaseFirestore.instance.collection('subject').snapshots();
      courseSnap.forEach((element) {
        element.docs.forEach((element) {
          log(element.data().toString());

          setState(() {
            int x = 3;
            subject.add(Subject.fromSnap(element));
            semester =
                subject.where((element) => element.semester == x).toList();
          });
          log(semester.length.toString());
        });
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
          bottom: const TabBar(
            tabs: [
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
                    InkWell(
                      onTap: null,
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
