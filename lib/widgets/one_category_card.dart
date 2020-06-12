import 'package:flutter/material.dart';

class OneCategoryCard extends StatelessWidget {
  final IconData icon;
  final String nameCategory;
  final Function onTap;
  OneCategoryCard({this.icon, @required this.nameCategory, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(245, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
    ),
      elevation: 4,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(150),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 80,),
            Text(nameCategory, style: TextStyle(
              fontSize: 20,
            ),)
          ],
        ),
      ),
    );
  }
}
