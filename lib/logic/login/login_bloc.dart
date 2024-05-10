import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

final Logger _logger = Logger();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginInitial()) {
    on<ValidateLogin>(_onValidateLogin);
    on<InitializeLogin>((_, emit) => emit(LoginInitial()));
    on<UpdateAutologin>(_onUpdateAutologin);
  }

  Future<void> _onValidateLogin(
      ValidateLogin event, Emitter<LoginState> emit) async {
    if (event.username.isNotEmpty && event.password.isNotEmpty) {
      try {
        _logger.i('Validating login for user ${event.username}');
        emit(ValidatingLogin());
        await _authenticationRepository.logIn(
          username: event.username,
          password: event.password,
        );
        _logger.i('User ${event.username} logged in successfully');
        emit(LoginSuccess());
      } catch (_) {
        _logger.w('Invalid username or password');
        emit(LoginFailure('Invalid username or password'));
      }
    } else {
      emit(LoginInitial());
    }
  }

  Future<void> _onUpdateAutologin(
    UpdateAutologin event,
    Emitter<LoginState> emit,
  ) async {
    if (!event.autologin) {
      _authenticationRepository.logOut();
    }
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('autologin', event.autologin);
    });
    _logger.i('Autologin changed to ${event.autologin}');
    emit(AutologinChanged(event.autologin));
  }
}
