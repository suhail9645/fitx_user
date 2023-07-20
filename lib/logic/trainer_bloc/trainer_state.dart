part of 'trainer_bloc.dart';

abstract class TrainerState {
}

class TrainerInitial extends TrainerState {}

class TrainerApplySuccessfull extends TrainerState{}

class TrainerApplyError extends TrainerState{
  final String error;

 TrainerApplyError({required this.error});

}
class TrainerApplyLoading extends TrainerState{}