import 'package:flutter/material.dart';
import 'package:quizomania/screens/pick_category_page.dart';
import 'package:quizomania/screens/question_page.dart';
import 'package:quizomania/widgets/big_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //i dont know why this button it is not on center!
          SizedBox(width:40),
          BigButton(
            color: Colors.blue,
            text: 'Start',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PickCategoryPage()));
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage('assets/images/logo_quiz.png'),
              width:200
            ),
          ),
        ],
      ),
    );
  }
}
