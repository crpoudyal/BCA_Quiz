import 'package:bca_quiz/screen/home_screen.dart';
import 'package:bca_quiz/screen/profile_screen.dart';
import 'package:bca_quiz/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return Scaffold(
      body: PageView(
        children: [
          HomeScreen(),
          Text("Course"),
          Text("Favorite"),
          ProfileScreen(
            uid: FirebaseAuth.instance.currentUser!.uid,
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
            icon: Icon(Icons.favorite,
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
