import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmDialog extends StatelessWidget {
  final String content;
  final onPressYes;

  ConfirmDialog({this.content, this.onPressYes});

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
            if (onPressYes == null) {
              Navigator.of(context).pop(true);
            }
            else
              SystemNavigator.pop();
          },
        ),
      ],
    );
  }
}
