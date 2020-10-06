import 'package:flutter/material.dart';

class AnswerText extends StatelessWidget {
  const AnswerText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
    );
  }
}
