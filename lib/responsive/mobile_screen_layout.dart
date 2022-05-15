import 'package:bca_quiz/screen/course_screen.dart';
import 'package:bca_quiz/screen/home_screen.dart';
import 'package:bca_quiz/screen/profile_screen.dart';
import 'package:bca_quiz/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    print("-------" + uid);
    String sid = "";
    return Scaffold(
      body: PageView(
        children: [
          HomeScreen(),
          CourseScreen(
            sid: sid,
          ),
          Container(color: Colors.amber),
          ProfileScreen(
            uid: uid,
          ),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _page == 0 ? mobileBottom : Colors.grey),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book,
                color: _page == 1 ? mobileBottom : Colors.grey),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard,
                color: _page == 2 ? mobileBottom : Colors.grey),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _page == 3 ? mobileBottom : Colors.grey),
            label: '',
            backgroundColor: Colors.white,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
