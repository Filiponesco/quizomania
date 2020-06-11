import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizomania/model/category/category_bloc.dart';
import 'package:quizomania/screens/pick_category.dart';
import 'package:quizomania/screens/pick_specification_questions_dialog.dart';
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
      home: MyHomePage(),
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
      //rgb(37, 44, 73)
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: Image(
              image: AssetImage('assets/images/logo_quiz.png'),
            ),
          ),
          SizedBox(
            height: 170,
          ),
          BigButton(
            color: Colors.blue,
            text: 'Start',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => CategoryBloc(),
                    child: PickCategoryPage(),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
