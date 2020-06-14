import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizomania/main.dart';
import 'package:quizomania/screens/confirm_dialog.dart';
import 'package:quizomania/widgets/big_button.dart';
import 'package:quizomania/widgets/my_back_button.dart';

class ResultPage extends StatelessWidget {
  //ScoreTable(this.score, this.totalScore, this.percentage);
  final int score;
  final int totalScore;
  final double percentage;

  ResultPage(
      {@required this.score, @required this.totalScore, @required this.percentage});

  @override
  Widget build(BuildContext context) {
    String _description;
    Color _colorCard;
    if (percentage < 0.33) {
      _description = 'Bad Luck';
      _colorCard = Colors.red;
    }
    else if (percentage < 0.5) {
      _description = 'Not bad';
      _colorCard = Colors.orange;
    }
    else if (percentage < 0.75) {
      _description = 'Good Job!';
      _colorCard = Colors.green;
    }
    else {
      _description = 'Congratulations!';
      _colorCard = Colors.blue;
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
              left: 25, right: 25, top: 40, bottom: 15),
          child: Stack(
              children: <Widget>[ Column(
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
                        color: _colorCard,
                        elevation: 8,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '$_description\nYour Actual Score',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: 'Balsamiq',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${(percentage * 100).floor()}%',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 80.0,
                                      fontFamily: 'Balsamiq',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1
                                  ),
                                ),
                                Text(
                                  '${'Good Answers: $score/$totalScore'}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Balsamiq',
                                      color: Colors.white,
                                      letterSpacing: 1
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
                          showDialog(context: context,
                              builder: (context){
                            return ConfirmDialog(
                                content: 'Are you sure you want to exit app?');
                            //SystemNavigator.pop();
                          }
                          );
                        },
                      ),
                      BigButton(
                        color: Colors.green,
                        text: 'Play Again',
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context)=> MyHomePage()));
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
