import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:quizomania/models/category.dart';
import 'package:quizomania/services/repository.dart';
import 'package:rxdart/rxdart.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  List<Category> categories = [];
  Repository repo = Repository();

  @override
  CategoryState get initialState => CategoryInitial();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    debugPrint('$runtimeType: event is: $event');
    if (event is LoadCategories) {
      try {
        if (categories.isEmpty) {
          //download only one time
          yield LoadingCategories('Outro');
          categories = await repo.getAllCategories();
        }
        await Future.delayed(Duration(seconds: 7));
        debugPrint('$runtimeType: yield: CategoryList');
        yield CategoryList(categories);
      } catch (e) {
        print(e);
        yield CategoryError();
      }
    } else if (event is EndOutro) {
      debugPrint('$runtimeType: yield: Loading');
      //only when is still loading
      if (categories.isEmpty) yield LoadingCategories('Loading');
    }
  }

  @override
  void onTransition(Transition<CategoryEvent, CategoryState> transition) {
    debugPrint("$runtimeType: $transition");
    super.onTransition(transition);
  }

  @override
  Stream<Transition<CategoryEvent, CategoryState>> transformEvents(
      Stream<CategoryEvent> events, transitionFn) {
    return events.flatMap(transitionFn);
  }
}
