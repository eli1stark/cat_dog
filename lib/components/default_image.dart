import 'package:flutter/material.dart';

class DefaultImage extends StatelessWidget {
  const DefaultImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.0,
      child: Column(
        children: [
          Image.asset(
            'assets/dog_cat.png',
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
