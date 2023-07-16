part of 'trainer_bloc.dart';

abstract class TrainerEvent {}

class TrainerApplyEvent extends TrainerEvent {
  final List<File> certificates;

  TrainerApplyEvent({required this.certificates});
}
