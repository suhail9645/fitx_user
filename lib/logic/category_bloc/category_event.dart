part of 'category_bloc.dart';

abstract class CategoryEvent {}

class CategoryInitialEvent extends CategoryEvent {}

class CategoryLikedUnLikedEvent extends CategoryEvent{
  final int id;
  final bool isLiked;
  CategoryLikedUnLikedEvent({required this.id,required this.isLiked});

}

// class CategoryUnlikedEvent extends CategoryEvent{
//   final int id;
//   final bool isLiked;
//   CategoryUnlikedEvent({required this.id,required this.isLiked});
// } 
