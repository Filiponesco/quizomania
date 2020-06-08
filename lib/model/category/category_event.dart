part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class LoadCategories extends CategoryEvent {
  final bool error;

  LoadCategories(this.error);
}

class SelectCategory extends CategoryEvent{
  final int id;

  SelectCategory(this.id);
}
