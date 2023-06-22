import 'dart:async';
import 'dart:convert';
import 'package:fitx_user/data_layer/repositories/exercise_repo/category_exercise_repo.dart';
import 'package:http/http.dart';
import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/category/category_operation_imp.dart';
import 'package:fitx_user/data_layer/models/category/category_page/category_page.dart';
import 'package:fitx_user/data_layer/models/category/category_page/result.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';

class CategoriesOperationsRepo {
  Future<Either<ErrorModel, List<Category>>> giveAllCategories() async {
    final response = await CategoryOperations().getAllCategories();
    if (response.isLeft) {
      return Left(ErrorModel(response.left.error));
    } else {
      Response categoriesResponse = response.right;
      List<Category> categories = [];
      while (true) {
        Map<String, dynamic> data = jsonDecode(categoriesResponse.body);
        CategoryPage categoryPage = CategoryPage.fromJson(data);

        for (var element in categoryPage.results ?? []) {
          Category categoryModel = Category.fromJson(element);
           final listOfExercise=await CategoryExerciseOperationsRepo().getAllCategoryExercise(categoryModel.id!);
           if(listOfExercise.isRight){
            categoryModel.exercises.addAll(listOfExercise.right);
           }
          categories.add(categoryModel);
        }

        if (categoryPage.next != null) {
          final nextPageResponse = await CategoryOperations()
              .getNextPageCategories(categoryPage.next);
          if (nextPageResponse.isRight) {
            categoriesResponse = nextPageResponse.right;
          }
        } else {
          break;
        }
      }
      return Right(categories);
    }
  }
}
