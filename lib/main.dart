import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizomania/screens/pick_category_page.dart';
import 'package:quizomania/screens/question_page.dart';
import 'package:quizomania/widgets/big_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
    Size size = MediaQuery.of(context).size;
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
      body: Center(
        child: Image(
          image: AssetImage('assets/images/main_page_bg.png'),
          height: size.height,
        ),
      ),
    );
  }
}
