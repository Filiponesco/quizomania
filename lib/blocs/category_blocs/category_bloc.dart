import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:quizomania/models/category.dart';
import 'package:quizomania/services/repository.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  List<Category> categories = [];
  Repository repo = Repository();

  @override
  CategoryState get initialState => CategoryInitial();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if(event is LoadCategories){
      try{
        if(categories.isEmpty){
          //download only one time
          yield LoadingCategories();
          categories = await repo.getAllCategories();
        }
        yield CategoryList(categories);
      }catch(e){
        print(e);
        yield CategoryError();
      }
    }
  }
  @override
  void onTransition(Transition<CategoryEvent, CategoryState> transition) {
    debugPrint("$runtimeType: $transition");
    super.onTransition(transition);
  }
}
