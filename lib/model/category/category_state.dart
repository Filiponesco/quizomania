part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryList extends CategoryState {
  final List<Category> categories;

  CategoryList(this.categories);
}

class CategoryError extends CategoryState {}

class NewTest extends CategoryState {}

class LoadingTest extends CategoryState {}
