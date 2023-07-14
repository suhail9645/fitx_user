part of 'report_bloc.dart';

abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportInitialState extends ReportState {
  final UserReport userReport;

  ReportInitialState({required this.userReport});
}

class ReportLoadingState extends ReportState{
  
}
class ImageAddLoadingState extends ReportState{}
