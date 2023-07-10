import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fitx_user/data_layer/models/user_report/user_report.dart';
import 'package:fitx_user/data_layer/models/user_weight/result.dart';
import 'package:fitx_user/data_layer/repositories/user_report_repo/user_completed.dart';
import 'package:fitx_user/data_layer/repositories/user_report_repo/user_goal_add.dart';
import 'package:fitx_user/data_layer/repositories/user_report_repo/user_weight_add.dart';
import 'package:intl/intl.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial()) {
    on<ReportInitialEvent>(reportInitialEvent);
    on<UpadateGoalEvent>(upadateGoalEvent);
    on<UpdateWeightEvent>(upadateWeightlEvent);
  }

  FutureOr<void> reportInitialEvent(
      ReportInitialEvent event, Emitter<ReportState> emit) async {
    UserReport userReport = await UserReportRepo().getAllUserDetailes();
    emit(ReportInitialState(userReport: userReport));
  }

  FutureOr<void> upadateGoalEvent(
      UpadateGoalEvent event, Emitter<ReportState> emit) async {
    UserGoalsAddrepo().updateUserGoal(event.categoryGoal, event.exerciseGoal,
        event.calorieGoal, event.userReport);
    UserReport userReport = event.userReport;
    userReport.categoryGoal = event.categoryGoal ?? userReport.categoryGoal;
    userReport.exerciseGoal = event.exerciseGoal ?? userReport.exerciseGoal;
    userReport.calorieGoal = event.calorieGoal ?? userReport.calorieGoal;

    emit(ReportInitialState(userReport: userReport));
  }

  FutureOr<void> upadateWeightlEvent(UpdateWeightEvent event, Emitter<ReportState> emit) async{
    UserWeitghtAddRepo().addUserWeight(event.weight);
    UserReport userReport=event.userReport;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    Weight weight=Weight(date: formattedDate,weight: event.weight);
    userReport.allWeights.add(weight);
    emit(ReportInitialState(userReport: userReport));
  }
}
