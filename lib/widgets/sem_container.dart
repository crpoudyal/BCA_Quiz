import 'package:flutter/material.dart';

Widget semContainer(String sName, Color clr, IconData ico) {
  return Container(
    margin: const EdgeInsets.all(5),
    width: 50,
    height: 50,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          ico,
        ),
        Text(
          sName,
          style: const TextStyle(color: Colors.white),
        )
      ],
    ),
    decoration: BoxDecoration(
      color: clr,
      borderRadius: BorderRadius.circular(5),
    ),
  );
}
