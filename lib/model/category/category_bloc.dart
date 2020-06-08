import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quizomania/model/category.dart';
import 'package:quizomania/model/question.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  List<Category> categories = [
    Category(1, "Category 1"),
    Category(2, "Category 2"),
    Category(3, "Category 3"),
    Category(4, "Category 4"),
    Category(5, "Category 5"),
    Category(6, "Category 6"),
    Category(7, "Category 7"),
  ];

  @override
  CategoryState get initialState => CategoryList(categories);

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if(event is LoadCategories){
      if(event.error){
        yield CategoryError();
      }
      else{
        yield CategoryList(categories);
      }
    }
    else if(event is SelectCategory){
      yield LoadingTest();
      Future.delayed(Duration(seconds: 2));
      yield NewTest();
    }
  }
}
