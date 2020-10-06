import 'package:flutter/material.dart';

class HeaderFirst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'TeachableMachine.com CNN',
      style: TextStyle(
        color: Color(0xFFEEDA28),
        fontSize: 18.0,
      ),
    );
  }
}

class HeaderSecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Detect Dogs and Cats',
      style: TextStyle(
        color: Color(0xFFE99600),
        fontSize: 28.0,
      ),
    );
  }
}
