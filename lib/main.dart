import 'package:bca_quiz/responsive/web_screen_layout.dart';
import 'package:bca_quiz/screen/login_screen.dart';
import 'package:bca_quiz/screen/signup_screen.dart';
import 'package:bca_quiz/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDBrrOxUMkiKGD0U42MM0jimWxmaMFJyXg",
        appId: "1:644571177544:web:fce07418152fa904266e7d",
        messagingSenderId: "644571177544",
        projectId: "bca-quiz-d0361",
        storageBucket: "bca-quiz-d0361.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
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
      home: const SignupScreen(),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
    );
  }
}
