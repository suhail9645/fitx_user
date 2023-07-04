part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {
  final List<Category> catgories;

  CategoryInitial({required this.catgories});
}

class CategoryLoadingState extends CategoryState {}

class CategoryErrorState extends CategoryState {
  final String error;

  CategoryErrorState({required this.error});
}
