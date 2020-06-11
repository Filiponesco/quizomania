import 'package:flutter/material.dart';

class DifficultyButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;

  const DifficultyButton({Key key, this.text, this.color, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 180,
      height: 40,
      child: RaisedButton(
        color: color,
        child: Text(text,
            style: TextStyle(
                fontFamily: 'Balsamiq',
                fontSize: 18,
                color: Colors.white,
                letterSpacing: 1)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        onPressed: onPressed,
      ),
    );
  }
}