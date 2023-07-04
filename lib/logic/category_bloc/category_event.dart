part of 'category_bloc.dart';

abstract class CategoryEvent {}

class CategoryInitialEvent extends CategoryEvent {}

class ExercisCompletedEvent extends CategoryEvent {
  final int categoryId;
  final int exerciseId;

  ExercisCompletedEvent({required this.categoryId, required this.exerciseId});
}
