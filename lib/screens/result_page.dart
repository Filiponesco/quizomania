import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizomania/widgets/big_button.dart';
import 'package:quizomania/widgets/my_back_button.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 40, bottom: 15),
        child: Stack(
          children:<Widget>[ Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/logo_quiz.png'),
                  width: 100,
                ),
                SizedBox(height: 30,),
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.green,
                    elevation: 8,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Your Actual \nScore',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'Balsamiq',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text(
                              '81',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 80.0,
                                fontFamily: 'Balsamiq',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 7
                              ),
                            ),
                          ],
                        ),
                      ),
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
              ]),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BigButton(
                    fontColor: Colors.black,
                    color: Colors.white,
                    text: 'Close',
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  BigButton(
                    color: Colors.green,
                    text: 'Play Again',
                    onPressed: () {
                    },
                  ),
                ],
              ),
            ),
            ]),
      )
    );
  }
}
