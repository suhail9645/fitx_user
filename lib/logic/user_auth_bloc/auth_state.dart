part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthActionState extends AuthState {}

class AuthSuccessState extends AuthActionState {}

class AuthErrorState extends AuthActionState {
  final String error;

  AuthErrorState({required this.error});
}
