part of 'report_bloc.dart';

abstract class ReportEvent {}

class ReportInitialEvent extends ReportEvent {}

class UpadateGoalEvent extends ReportEvent {
  final int? categoryGoal;
  final int? exerciseGoal;
  final int? calorieGoal;
  final UserReport userReport;
  UpadateGoalEvent(
      this.categoryGoal, this.exerciseGoal, this.calorieGoal, this.userReport);
}
