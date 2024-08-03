import 'package:flutter/material.dart';
import 'package:project1/second_screen.dart';

import 'main_screen.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '2ndscreen':(context) => const SecondScreen(),

      },
      debugShowCheckedModeBanner: false,
      home: const MainApp()),

  );
}


