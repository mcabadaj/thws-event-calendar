part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

class InitializeLogin extends LoginEvent {
  const InitializeLogin();
}

class ValidateLogin extends LoginEvent {
  final String username;
  final String password;

  const ValidateLogin(this.username, this.password);
}

class UpdateAutologin extends LoginEvent {
  final bool autologin;

  const UpdateAutologin(this.autologin);
}
