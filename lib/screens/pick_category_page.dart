import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizomania/model/category.dart';
import 'package:quizomania/model/category/category_bloc.dart';
import 'package:quizomania/screens/pick_specification_questions_dialog.dart';
import 'package:quizomania/widgets/one_category_card.dart';

class PickCategoryPage extends StatefulWidget {
  @override
  _PickCategoryPageState createState() => _PickCategoryPageState();
}

class _PickCategoryPageState extends State<PickCategoryPage> {
  CategoryBloc _categoryBloc;

  void _onPickCategory(Category category, context) {
    print('selected category id: ${category.id}');
    showDialog(
        context: context,
        builder: (BuildContext context) => SpecificationQuestionsDialog(
              selectedCategory: category,
            ));
  }

  @override
  void initState() {
    _categoryBloc = CategoryBloc()..add(LoadCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Center(
        child:
            Image(image: AssetImage('assets/images/logo_quiz.png'), width: 200),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          bloc: _categoryBloc,
          builder: (context, state) {
            if (state is LoadingTest) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CategoryList) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  Color bgColor;
                  if(index % 4 == 0)
                    bgColor = Colors.pink;
                  else if(index % 4 == 1){
                    bgColor = Colors.orange;
                  }
                  else if(index % 4 == 2){
                    bgColor = Colors.blue;
                  }
                  else if(index % 4 == 3){
                    bgColor = Colors.green;
                  }
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: OneCategoryCard(
                      nameCategory: state.categories[index].category,
                      backgroundColor: bgColor,
                      onTap: () =>
                          _onPickCategory(state.categories[index], context),
                    ),
                  );
                },
                itemCount: state.categories.length,
              );
            } else {
              return Center(child: Text('state is: ${state.toString()}'));
            }
          },
        ),
      ),
    ]));
  }

  @override
  void dispose() {
    _categoryBloc.close();
    super.dispose();
  }
}
