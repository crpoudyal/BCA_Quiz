import 'package:bca_quiz/responsive/mobile_screen_layout.dart';
import 'package:bca_quiz/screen/home_screen.dart';
import 'package:bca_quiz/utils/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MobileScreenLayout()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/BCAquiz.png",
                    width: 150,
                    height: 150,
                  ),
                  const CircularProgressIndicator()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
