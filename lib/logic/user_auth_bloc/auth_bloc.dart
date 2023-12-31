import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fitx_user/data_layer/data_provider/auth/user_auth_imp.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
    on<SignInButtonClickedEvent>(signInButtonClickedEvent);
    on<SignOutButtonClickedEvent>(signOutButtonClickedEvent);
  }

  FutureOr<void> signUpButtonClickedEvent(
      SignUpButtonClickedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final response =
        await UserAuthFunctions().registerUser(event.image, event.groupValue);
    if (response.isRight) {
      emit(AuthSuccessState(userName: response.right));
    } else {
      emit(AuthErrorState(error: response.left.error));
    }
  }

  FutureOr<void> signInButtonClickedEvent(
      SignInButtonClickedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final response = await UserAuthFunctions().loginUser();
    if (response.isRight) {
      emit(AuthSuccessState(userName: response.right));
    } else {
      emit(AuthErrorState(error: response.left.error));
    }
  }

  FutureOr<void> signOutButtonClickedEvent(
      SignOutButtonClickedEvent event, Emitter<AuthState> emit) async {
    emit(SignOutButtonClickedState());
  }
}
