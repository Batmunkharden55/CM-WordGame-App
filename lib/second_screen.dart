import 'package:flutter/material.dart';
import 'package:project1/third_screen.dart';

import 'main_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool wordWritten = false;
  late String myName;
  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  makeButton() {
    wordWritten = true;
  }

  void _validate() {
    final form = formKey.currentState;
    if (!form!.validate()) {
      return;
    }
    myName = nameController.text;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ThirdScreen(ner: myName)));
    wordWritten = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/back2.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'assets/previous 1.png',
                              height: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          const Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Sq(
                                  screenWord: 'W',
                                  hemjee: 40,
                                  border: 10,
                                ),
                                Sq(
                                  screenWord: 'O',
                                  hemjee: 40,
                                  border: 10,
                                ),
                                Sq(
                                  screenWord: 'R',
                                  hemjee: 40,
                                  border: 10,
                                ),
                                Sq(
                                  screenWord: 'D',
                                  hemjee: 40,
                                  border: 10,
                                ),
                                SizedBox(
                                  width: 30,
                                )
                              ],
                            ),
                            Text(
                              'GAME',
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 20,
                                  fontFamily: 'Ribeye',
                                  fontWeight: FontWeight.w400),
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Image.asset('assets/icodeGuyHead.png'),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Player name',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 34,
                          fontFamily: 'Ribeye',
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'neree bicheechee';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            setState(() {
                              makeButton();
                            });
                          },
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          decoration: InputDecoration(
                            label: const Text(
                              'Type here',
                              style: TextStyle(
                                color: Colors.orangeAccent,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              icon: Image.asset('assets/close.png'),
                              onPressed: () {
                                nameController.clear();
                              },
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      if (wordWritten)
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
                                _validate();
                              },
                              child: const Text(
                                'START',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              )),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
