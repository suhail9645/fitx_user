part of 'category_like_cubit.dart';

abstract class CategoryLikeState {
}

class CategoryLikeInitial extends CategoryLikeState {}

class CategoryLikeUnlikeState extends CategoryLikeState{
  final bool isLiked;
  final int likeCount;

  CategoryLikeUnlikeState({required this.isLiked,required this.likeCount});
}
