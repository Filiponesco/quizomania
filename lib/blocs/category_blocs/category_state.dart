part of 'category_bloc.dart';

@immutable
abstract class CategoryState extends Equatable{
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState{}
class CategoryList extends CategoryState {
  final List<Category> categories;

  CategoryList(this.categories);
}

class CategoryError extends CategoryState {}

//for animation
class LoadingCategories extends CategoryState {
  final String animationName;
  LoadingCategories(this.animationName);
  @override
  // TODO: implement props
  List<Object> get props => [animationName];
}

