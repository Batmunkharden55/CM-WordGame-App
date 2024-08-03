import 'package:flutter/material.dart';

class HiddenWidget extends StatelessWidget {
  const HiddenWidget(
      {super.key,
      required this.letter,
      required this.height,
      required this.width});
  final String letter;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.orange),
      alignment: Alignment.center,
      child: Container(
        width: width - 18,
        height: height - 18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xFFE48000)),
        alignment: Alignment.center,
        child: Text(
          letter,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'Ribeye', fontSize: 22),
        ),
      ),
    );
  }
}
