import 'package:bloc/bloc.dart';
import 'package:fitx_user/data_layer/data_provider/category/category_like_dislike.dart';
import 'package:fitx_user/data_layer/models/category/category_page/result.dart';

part 'category_like_state.dart';

class CategoryLikeCubit extends Cubit<CategoryLikeState> {
  CategoryLikeCubit() : super(CategoryLikeInitial());

  Future<void> onLikeAndUnlike(int? id, Category category, int likeCount) async {
    if (id == null) {
      emit(CategoryLikeUnlikeState(category: category, likeCount: likeCount));
    } else {
      if (category.isLiked) {
        CategoryLikeAndDislike().categoryDislike(id);
        category.isLiked=false;
        category.likes!-1;
        emit(CategoryLikeUnlikeState(
            category: category, likeCount: likeCount - 1));
      } else {
        CategoryLikeAndDislike().categoryLike(id);
        category.isLiked=true;
        category.likes!+1;
        emit(CategoryLikeUnlikeState(
            category:category, likeCount: likeCount + 1));
      }
    }
  }
}
