import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: Text(
          'Check your internet connection.',
          style: TextStyle(fontFamily: 'Balsamiq')),
      title: Text('Something went wrong.'),
      actions: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)),
          color: Colors.blue,
          child: Text('Ok',
              style: TextStyle(fontFamily: 'Balsamiq')),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
