import 'package:bloc/bloc.dart';
import 'package:fitx_user/data_layer/data_provider/category/category_like_dislike.dart';

part 'category_like_state.dart';

class CategoryLikeCubit extends Cubit<CategoryLikeState> {
  CategoryLikeCubit() : super(CategoryLikeInitial());

  Future<void> onLikeAndUnlike(int? id, bool isLiked, int likeCount) async {
    if (id == null) {
      emit(CategoryLikeUnlikeState(isLiked: isLiked, likeCount: likeCount));
    } else {
      if (isLiked) {
        CategoryLikeAndDislike().categoryDislike(id);
        emit(CategoryLikeUnlikeState(
            isLiked: !isLiked, likeCount: likeCount - 1));
      } else {
        CategoryLikeAndDislike().categoryLike(id);
        emit(CategoryLikeUnlikeState(
            isLiked: !isLiked, likeCount: likeCount + 1));
      }
    }
  }
}
