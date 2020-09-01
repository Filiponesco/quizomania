import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizomania/models/category.dart';
import 'package:quizomania/blocs/category_blocs/category_bloc.dart';
import 'package:quizomania/blocs/setup_question_blocs/setup_question_bloc.dart';
import 'package:quizomania/models/enums_difficulty_answer.dart';
import 'package:quizomania/screens/pick_specification_questions_dialog.dart';
import 'package:quizomania/widgets/one_category_card.dart';

class PickCategoryPage extends StatelessWidget {
  final CategoryBloc _categoryBloc;
  PickCategoryPage(this._categoryBloc);
  void _onPickCategory(Category category, context) {
    print('selected category id: ${category.id}');
    showDialog(
        context: context,
        builder: (BuildContext context) => BlocProvider(
              create: (BuildContext context) => SetupQuestionBloc(DifficultyLevel.medium, 5),
              child: SpecificationQuestionsDialog(
                category: category,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          cubit: _categoryBloc,
          builder: (context, state) {
            if (state is CategoryList) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  Color bgColor;
                  if (index % 4 == 0)
                    bgColor = Colors.pink;
                  else if (index % 4 == 1) {
                    bgColor = Colors.orange;
                  } else if (index % 4 == 2) {
                    bgColor = Colors.blue;
                  } else if (index % 4 == 3) {
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
}
