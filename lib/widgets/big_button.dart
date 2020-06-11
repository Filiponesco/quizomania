import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final double radius;

  const BigButton(
      {Key key, this.text, this.onPressed, this.color, this.radius = 70.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 150,
      height: 70,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(text,
            style: TextStyle(
                fontFamily: 'Balsamiq',
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        onPressed: onPressed,
      ),
    );
  }
}
