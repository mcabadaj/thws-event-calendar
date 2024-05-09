part of 'login_bloc.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class ValidatingLogin extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}

class AutologinChanged extends LoginState {
  final bool autologin;

  AutologinChanged(this.autologin);
}
