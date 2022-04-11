import 'package:bca_quiz/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  var courseData = {};
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{
    try {
      var courseSnap = await FirebaseFirestore.instance
          .collection('firstSemester')
          .doc()
          .get();
      setState(() {
        courseData = courseSnap.data()!;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("First Semsester"),
      ),
      body: ListView(
        children: [
          Column(
            children: const [
              InkWell(
                onTap: null,
                child: ListTile(
                  textColor: mobileBackgroundColor,
                  title: Text(
                    "Digital Logic",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text("CACS102"),
                ),
              ),
              InkWell(
                onTap: null,
                child: ListTile(
                  textColor: mobileBackgroundColor,
                  title: Text(
                    "Digital Logic",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text("CACS102"),
                ),
              ),
              InkWell(
                onTap: null,
                child: ListTile(
                  textColor: mobileBackgroundColor,
                  title: Text(
                    "Digital Logic",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text("CACS102"),
                ),
              ),
              InkWell(
                onTap: null,
                child: ListTile(
                  textColor: mobileBackgroundColor,
                  title: Text(
                    "Digital Logic",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text("CACS102"),
                ),
              ),
              InkWell(
                onTap: null,
                child: ListTile(
                  textColor: mobileBackgroundColor,
                  title: Text(
                    "Digital Logic",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text("CACS102"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
