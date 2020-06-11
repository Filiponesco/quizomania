import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizomania/model/category.dart';
import 'package:quizomania/model/category/category_bloc.dart';
import 'package:quizomania/screens/pick_specification_questions_dialog.dart';
import 'package:quizomania/widgets/one_category_card.dart';

class PickCategoryPage extends StatelessWidget {
  void _onPickCategory(Category category, context){
    print('selected category id: ${category.id}');
    showDialog(context: context, builder: (BuildContext context)=> SpecificationQuestionsDialog());
  }
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryBloc>(context).add(LoadCategories(false));

    return Scaffold(
        body: BlocBuilder<CategoryBloc, CategoryState>(
      bloc: BlocProvider.of<CategoryBloc>(context),
      builder: (context, state) {
        if (state is LoadingTest) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CategoryList) {
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: OneCategoryCard(
                nameCategory: state.categories[index].category,
                icon: Icons.category,
                onTap: ()=>_onPickCategory(state.categories[index], context),
              ),
            ),
            itemCount: state.categories.length,
          );
        } else {
          return Center(child: Text('state is: ${state.toString()}'));
        }
      },
    ));
  }
}
