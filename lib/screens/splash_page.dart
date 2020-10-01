import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      title: Text(
        'Dog and Cat',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          color: Color(0xFFE99600),
        ),
      ),
      image: Image.asset('assets/dog_cat.png'),
      backgroundColor: Colors.black,
      photoSize: 50.0,
      loaderColor: Color(0xFFEEDA28),
      navigateAfterSeconds: Home(),
    );
  }
}
