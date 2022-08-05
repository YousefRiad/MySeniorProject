import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wqm/const.dart';
import 'package:wqm/pages/TDS.dart';
import 'package:wqm/pages/ph_sensor.dart';
import 'package:wqm/pages/temp_sensor.dart';
import 'package:wqm/pages/turbidity_sensor.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({Key? key}) : super(key: key);
  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  bool value1 = true;
  Color Active1 = Color.fromARGB(255, 39, 187, 71);
  Color btnColor = Color.fromARGB(255, 145, 143, 143);
  List<bool> _selections = List.generate(4, (index) => false);
  Color lightmode = Color.fromARGB(255, 164, 214, 243);
  Color pageColor = Color.fromARGB(255, 164, 214, 243);
  Color appBarLight = Color.fromARGB(255, 235, 235, 235);
  Color appBarColor = Color.fromARGB(255, 235, 235, 235);

  bool isPressed = true;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color.fromARGB(255, 164, 214, 243);
    Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
    double blur = isPressed ? 5.0 : 30.0;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 8,
        shadowColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.xmark,
            color: Colors.black,
            size: 22,
          ),
        ),
        backgroundColor: appBarColor,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
