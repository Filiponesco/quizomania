import 'package:flare_flutter/flare_actor.dart';
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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _nameAnimation = 'Intro';
  bool _snapEnd = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //i dont know why this button it is not on center!
          SizedBox(width: 40),
          BigButton(
            color: Colors.blue,
            text: 'Start',
            onPressed: () {
              setState(() {
                _nameAnimation = 'Outro';
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: FlareActor(
          "assets/animations/logo_anim.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: _nameAnimation,
          callback: (value) {
            debugPrint('$runtimeType: $value');
            if (value == 'Outro')
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PickCategoryPage()));
            setState(() {
              _nameAnimation = 'Intro';
            });
          },
        ),
      ),
    );
  }
}
