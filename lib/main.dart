import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizomania/blocs/category_blocs/category_bloc.dart';
import 'package:quizomania/screens/error_dialog.dart';
import 'package:quizomania/screens/pick_category_page.dart';
import 'package:quizomania/widgets/big_button.dart';

void main() {
  runApp(BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(), child: MyApp()));
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

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //i have here CategoryBloc: change state when loading on main screen
    return BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
      if (state is CategoryList) {
        debugPrint('$runtimeType: state is: CategoryList: Push');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contextBuilder) =>
                    PickCategoryPage(context.bloc<CategoryBloc>())));
      } else if (state is CategoryError)
        showDialog(context: context, builder: (_) => ErrorDialog());
    }, builder: (context, state) {
      if (state is LoadingCategories) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: //Container(color: Colors.red,),
              MyAnimation(
            state.animationName,
            key: UniqueKey(),
            callback: () {
              print('will be unikey?: ${UniqueKey()}');
              context.bloc<CategoryBloc>().add(EndOutro());
            },
          ),
        );
      } else {
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
                  context.bloc<CategoryBloc>().add(LoadCategories());
                },
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: MyAnimation(
            'Intro',
            key: UniqueKey(),
          ),
        );
      }
    });
  }
}

class MyAnimation extends StatelessWidget {
  const MyAnimation(
    this._animationName, {
    @required Key key,
    this.callback,
  }) : super(key: key);
  final _animationName;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return FlareActor(
      "assets/animations/logo_anim.flr",
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: _animationName,
      callback: (name) {
        debugPrint(
            '$runtimeType: unikey: $key, end of animation: $name, callback $callback');
        callback?.call();
      },
    );
  }
}
