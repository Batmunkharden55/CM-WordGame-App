import 'package:flutter/material.dart';
import 'package:project1/second_screen.dart';

import 'my_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: FlutterLogo(),
          actions: [InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyScreen()));
            },
            child: const CircleAvatar(
              backgroundImage: AssetImage('lib/assets/profile.JPG'),
            ),
          )],
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/back1.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Sq(
                          screenWord: 'W',
                          hemjee: 60,
                          border: 20,
                        ),
                        Sq(
                          screenWord: 'O',
                          hemjee: 60,
                          border: 20,
                        ),
                        Sq(
                          screenWord: 'R',
                          hemjee: 60,
                          border: 20,
                        ),
                        Sq(
                          screenWord: 'D',
                          hemjee: 60,
                          border: 20,
                        ),
                        SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                    const Text(
                      'GAME',
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 29,
                          fontFamily: 'Ribeye',
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Image.asset('assets/icodeGuy.png'),
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      'READY?',
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 25,
                          fontFamily: 'Ribeye',
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 310,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          gradient: const LinearGradient(
                              colors: [Colors.deepOrange, Colors.orange])),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '2ndscreen');
                          },
                          child: const Text(
                            'PLAY',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Sq extends StatelessWidget {
  const Sq(
      {super.key,
      required this.screenWord,
      required this.hemjee,
      required this.border});
  final String screenWord;
  final double hemjee;
  final double border;

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: [
      Container(
        height: hemjee,
        width: hemjee,
        decoration: ShapeDecoration(
            color: Colors.orange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(border))),
      ),
      Container(
        height: hemjee - 18,
        width: hemjee - 18,
        decoration: ShapeDecoration(
            color: Colors.black12,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(border - 10))),
      ),
      Text(
        screenWord,
        style: TextStyle(
            fontSize: hemjee - 20, fontFamily: 'Ribeye', color: Colors.white),
      )
    ]);
  }
}
