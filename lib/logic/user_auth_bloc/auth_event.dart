part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignUpButtonClickedEvent extends AuthEvent {
  final File? image;
  final String groupValue;

  SignUpButtonClickedEvent({required this.image, required this.groupValue});
}

class SignInButtonClickedEvent extends AuthEvent {}

class SignOutButtonClickedEvent extends AuthEvent{}
