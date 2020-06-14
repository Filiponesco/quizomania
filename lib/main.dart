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
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyHomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/category': (context) => PickCategoryPage(),
        '/question': (context) => QuestionPage(),
      },
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
          //i dont knwo why this button it is not on center!
          SizedBox(width:25),
          BigButton(
            color: Colors.blue,
            text: 'Start',
            onPressed: () {
              Navigator.of(context).pushNamed('/category');
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
