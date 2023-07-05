import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/user_report/user_report.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:fitx_user/data_layer/models/user_report/user_report.dart';
import 'package:fitx_user/presentation/constants/strings.dart';
import 'package:http/http.dart';

import '../exercise_repo/category_exercise_repo.dart';

class UserReportRepo {
   int allCompletedCategory=0;
    int allCompletedExercise = 0;
    int allCompletedCalorie = 0;
    int thisweekCompletedCategory=0;
    int thisweekCompletedExercise=0;
    int thisweekCompletedCalorie=0;
    int exerciseGoal=0;
    int categoryGoal=0;
    int calorieGoal=0;
  Future<void> getAllCategoryReport() async {
   
    Either<ErrorModel, Response> responseOrError = await UserReportOperations()
        .getAllCompletedCategoryAndExercise(completedCategoryEndPoint);
    responseOrError.fold((left) {
      return Left(ErrorModel(left.error));
    }, (right) async {
      List<int> allCompletedCategoryId = [];
      List<Exercise> allCompletedExerciseList = [];
      allCompletedCategory = jsonDecode(right.body)['count'];
      List allCompletedCategories = jsonDecode(right.body)['results'];
      for (var element in allCompletedCategories) {
        //  DateTime completeDate=DateTime(2023, 7, 3);
        //  DateTime todayDate=DateTime.now();
        //   DateTime sunday = todayDate.subtract(Duration(days: todayDate.weekday));
        //  if(completeDate.isAfter(sunday)){

        //  }
        allCompletedCategoryId.add(element['id']);
      }
      for (int element in allCompletedCategoryId) {
        final listOfExercise = await CategoryExerciseOperationsRepo()
            .getAllCategoryExercise(element);
        if (listOfExercise.isRight) {
          allCompletedExercise =
              allCompletedExercise + listOfExercise.right.length;
          allCompletedExerciseList.addAll(listOfExercise.right);
        }
      }
      for (var element in allCompletedExerciseList) {
        allCompletedCalorie = allCompletedCalorie + element.burnCalorie!;
      }
    });
   await getAllExerciseReport();
  }
 Future<void>getAllExerciseReport()async{
  Either<ErrorModel, Response> responseOrError = await UserReportOperations()
        .getAllCompletedCategoryAndExercise(completedExerciseEndPoint);
  if(responseOrError.isRight){
    List<int>allCompletedExerciseids=[];
    Response response=responseOrError.right;
    int exercise=jsonDecode(response.body)['count'];
    allCompletedExercise=allCompletedExercise+exercise;
    List allExerciseDetailes=jsonDecode(response.body)['results'];
    for (var element in allExerciseDetailes) {
    allCompletedExerciseids.add(element['id']);
    }
  }
 }

}
