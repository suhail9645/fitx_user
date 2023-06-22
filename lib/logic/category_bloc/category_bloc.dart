import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:fitx_user/data_layer/repositories/category_repo/category_operations_repo.dart';

import '../../data_layer/models/category/category_page/result.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial(catgories: [])) {
    on<CategoryInitialEvent>(categoryInitialEvent);
  }

  FutureOr<void> categoryInitialEvent(
      CategoryInitialEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final result = await CategoriesOperationsRepo().giveAllCategories();
    if (result.isRight) {
      emit(CategoryInitial(catgories: result.right));
    } else {
      emit(CategoryErrorState(error: result.left.error));
    }
  }
}
