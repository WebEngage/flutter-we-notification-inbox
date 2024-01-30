import 'package:flutter/material.dart';

class CustomWidgets {
  static Widget button(label, callback) => GestureDetector(
        onTap: callback,
        child: Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 73, 148, 236),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: const EdgeInsets.all(20),
          width: 100.0,
          height: 40.0,
          child: Center(
              child: Text(
            "$label",
            style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontStyle: FontStyle.italic,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
        ),
      );

  static Widget button2(label, callback) => GestureDetector(
        onTap: callback,
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xFF458BE7),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          margin: const EdgeInsets.all(10),
          child: Center(
              child: Text(
            "$label",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          )),
        ),
      );
}
