import 'package:flutter/material.dart';
import 'package:quizomania/widgets/big_button.dart';

class ConfirmDialog extends StatelessWidget {
  final String content;
  ConfirmDialog({this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: Text(
          content,
          style: TextStyle(fontFamily: 'Balsamiq')),
      actions: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)),
          child: Text('No', style: TextStyle(fontFamily: 'Balsamiq')),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        FlatButton(
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)),
          color: Colors.blue,
          child: Text('Yes, exit',
              style: TextStyle(fontFamily: 'Balsamiq')),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
