import 'dart:async';

import '../user/user.dart';
import '../user/user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final UserRepository _userRepository;

  AuthenticationRepository({required UserRepository userRepository})
      : _userRepository = userRepository;

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn(
      {required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      _userRepository.user = User(username, password);
      _controller.add(AuthenticationStatus.authenticated);
    });
  }

  void logOut() {
    _userRepository.user = null;
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    _controller.close();
  }
}
