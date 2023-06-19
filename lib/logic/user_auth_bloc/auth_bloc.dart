import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fitx_user/data_layer/data_provider/user_auth_imp.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
  on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
  on<SignInButtonClickedEvent>(signInButtonClickedEvent);
  }

  FutureOr<void> signUpButtonClickedEvent(SignUpButtonClickedEvent event, Emitter<AuthState> emit)async {
    emit(AuthLoadingState());
    final response=await UserAuthFunctions().registerUser(event.image,event.groupValue);
    if(response.isRight){
      emit(AuthSuccessState());
    }else {
     emit(AuthErrorState(error: response.left.error));
    }
  }

  FutureOr<void> signInButtonClickedEvent(SignInButtonClickedEvent event, Emitter<AuthState> emit)async {
       emit(AuthLoadingState());
    final response=await UserAuthFunctions().loginUser();
    if(response.isRight){
      emit(AuthSuccessState());
    }else {
      emit(AuthErrorState(error: response.left.error));
    }
  }
}
