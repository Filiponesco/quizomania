import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:quizomania/model/difficulty_level.dart';
import 'package:quizomania/screens/pick_category.dart';
import 'package:quizomania/widgets/my_back_button.dart';
import 'package:quizomania/widgets/big_button.dart';
import 'package:quizomania/widgets/difficulty_button.dart';

class SpecificationQuestionsDialog extends StatefulWidget {
  @override
  _SpecificationQuestionsDialogState createState() =>
      _SpecificationQuestionsDialogState();
}

class _SpecificationQuestionsDialogState
    extends State<SpecificationQuestionsDialog> {
  DifficultyLevel _pickedLevel;
  int _numberOfQuestion = 7;

  void _onPickDifficulty(DifficultyLevel level) {
    setState(() {
      _pickedLevel = level;
    });
  }

  void _changeNumberOfQuestion(int pickedNumber) {
    setState(() {
      _numberOfQuestion = pickedNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 25, right: 25, bottom: 20),
              child: Column(
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 21, fontFamily: 'Balsamiq'),
                      children: [
                        TextSpan(
                            text: "Select the ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text: "difficulty",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextSpan(
                            text: " \nof questions ",
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DifficultyButton(
                    text: 'Easy',
                    color: Colors.blue,
                    onPressed: _pickedLevel == DifficultyLevel.easy
                        ? null
                        : () => _onPickDifficulty(DifficultyLevel.easy),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  DifficultyButton(
                    text: 'Medium',
                    color: Colors.orange,
                    onPressed: _pickedLevel == DifficultyLevel.medium
                        ? null
                        : () => _onPickDifficulty(DifficultyLevel.medium),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  DifficultyButton(
                    text: 'Hard',
                    color: Colors.red,
                    onPressed: _pickedLevel == DifficultyLevel.hard
                        ? null
                        : () => _onPickDifficulty(DifficultyLevel.hard),
                  )
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 21, fontFamily: 'Balsamiq'),
                children: [
                  TextSpan(
                      text: "Pick the ",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: "number",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                      text: " \nof questions ",
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            NumberPicker.horizontal(
                initialValue: _numberOfQuestion,
                minValue: 1,
                maxValue: 25,
                onChanged: (num) => _changeNumberOfQuestion(num)),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            MyBackButton(
              radius: 30.0,
            ),
            BigButton(
              radius: 30.0,
              text: 'Start',
              color: Colors.blue,
              onPressed: _pickedLevel == null
                  ? null
                  : () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PickCategoryPage()));
                    },
            ),
              ],
            )
          ],
        ));
  }
}
