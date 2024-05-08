import 'package:bloc/bloc.dart';

import '../../repositories/authentication/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginInitial()) {
    on<ValidateLogin>(_onValidateLogin);
    on<InitializeLogin>((_, emit) => emit(LoginInitial()));
  }

  Future<void> _onValidateLogin(
      ValidateLogin event, Emitter<LoginState> emit) async {
    if (event.username.isNotEmpty && event.password.isNotEmpty) {
      try {
        emit(ValidatingLogin());
        await _authenticationRepository.logIn(
          username: event.username,
          password: event.password,
        );
        emit(LoginSuccess());
      } catch (_) {
        emit(LoginFailure('Invalid username or password'));
      }
    } else {
      emit(LoginInitial());
    }
  }
}
