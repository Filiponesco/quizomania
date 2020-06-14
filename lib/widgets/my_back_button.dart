import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  final double radius;
  final Function onPressed;
  final IconData icon;
  const MyBackButton({
    Key key,
    this.radius = 70,
    this.onPressed,
    this.icon = Icons.arrow_back
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 90,
      height: 70,
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Icon(
            icon
        ),
        onPressed: onPressed,
      ),
    );
  }
}