import 'package:flutter/material.dart';

Widget semContainer(String sName, Color clr, IconData ico, Function onTap) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      margin: const EdgeInsets.all(5),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: clr,
        borderRadius: BorderRadius.circular(5),
      ),
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
    ),
  );
}
