import 'package:bca_quiz/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final webScreenLayout;
  final mobileScreenLayout;

  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return webScreenLayout;
        } else {
          return mobileScreenLayout;
        }
      },
    );
  }
}
