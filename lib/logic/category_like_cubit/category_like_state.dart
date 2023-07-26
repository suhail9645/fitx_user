part of 'category_like_cubit.dart';

abstract class CategoryLikeState {}

class CategoryLikeInitial extends CategoryLikeState {}

class CategoryLikeUnlikeState extends CategoryLikeState {
  final Category category;
  final int likeCount;

  CategoryLikeUnlikeState({required this.category, required this.likeCount});
}
