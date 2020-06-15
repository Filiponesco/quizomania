import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OneCategoryCard extends StatelessWidget {
  final String nameCategory;
  final Function onTap;
  final Color backgroundColor;
  OneCategoryCard({@required this.nameCategory, this.onTap, this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
    ),
      elevation: 3,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(150),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onTap: onTap,
        child:
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: AutoSizeText(nameCategory, style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Balsamiq',
                  letterSpacing: 1
                ),
                  maxLines: 2,
        ),
              ),
            ),
      ),
    );
  }
}
