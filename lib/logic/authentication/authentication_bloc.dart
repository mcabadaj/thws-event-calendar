import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

import '../../repositories/authentication/authentication_repository.dart';
import '../../repositories/user/user.dart';
import '../../repositories/user/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

Logger _logger = Logger();

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
    );
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  void _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.logOut();
  }

  Future<void> _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        _logger.i('Unauthenticated');
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _userRepository.getUser();
        _logger.i(user != null
            ? 'Authenticating as ${user.name}'
            : 'Unauthenticated');
        return emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated());
      case _:
        return emit(const AuthenticationState.unknown());
    }
  }
}
