import 'package:flutter/material.dart';
import 'package:quizomania/model/enums_difficulty_answer.dart';

class AnswerFieldCheck extends StatelessWidget {
  final Answer numberOfAnswer; //which answer is it 1-4?
  final Answer selectedAnswer; //which answer is selected?
  final String textAnswer;
  final Function onTap;
  const AnswerFieldCheck({
    Key key,
    @required this.numberOfAnswer,
    this.selectedAnswer,
    this.textAnswer,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  color: Color.fromARGB(255, 33, 72, 106), width: 4),
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 21, right: 13, top: 3, bottom: 3),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    textAnswer,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Balsamiq'),
                    textAlign: TextAlign.left,
                  ),
                ),
                Checkbox(
                  checkColor: Colors.blue,
                  value: numberOfAnswer == selectedAnswer ? true : false,
                ),
              ],
            ),
          )),
    );
  }
}