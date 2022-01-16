import 'package:bca_quiz/responsive/mobile_screen_layout.dart';
import 'package:bca_quiz/responsive/responsive_layout_screen.dart';
import 'package:bca_quiz/responsive/web_screen_layout.dart';
import 'package:bca_quiz/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BCA Quiz',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ));
  }
}
