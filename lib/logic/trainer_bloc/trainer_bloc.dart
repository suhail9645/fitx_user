import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fitx_user/data_layer/repositories/trainer_repo/trainer_apply_repo.dart';

part 'trainer_event.dart';
part 'trainer_state.dart';

class TrainerBloc extends Bloc<TrainerEvent, TrainerState> {
  TrainerBloc() : super(TrainerInitial()) {
    on<TrainerApplyEvent>(trainerApplyEvent);
  }

  FutureOr<void> trainerApplyEvent(
      TrainerApplyEvent event, Emitter<TrainerState> emit) async {
    emit(TrainerApplyLoading());
    final boolOrError =
        await TrainerApplyRepo().applyTrianer(event.certificates);
    if (boolOrError.isRight) {
      emit(TrainerApplySuccessfull());
    } else {
      emit(TrainerApplyError(error: boolOrError.left.error));
    }
  }
}
