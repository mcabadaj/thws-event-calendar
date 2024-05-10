import 'dart:async';

import '../models/user.dart';
import 'user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final UserRepository _userRepository;

  AuthenticationRepository({required UserRepository userRepository})
      : _userRepository = userRepository;

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    checkAuthenticationStatus();
    yield* _controller.stream;
  }

  void checkAuthenticationStatus() async {
    if (await _userRepository.getUser() != null) {
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> logIn(
      {required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      _userRepository.setUser(User(username));
      _controller.add(AuthenticationStatus.authenticated);
    });
  }

  void logOut() {
    _userRepository.setUser(null);
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    _controller.close();
  }
}
