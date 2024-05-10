import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thws_event_calendar/logic/login/login_bloc.dart';
import 'package:thws_event_calendar/presentation/widgets/login_form.dart';

import '../../data/repositories/authentication_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
            create: (context) {
              return LoginBloc(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context));
            },
            child: LoginForm()),
      ),
    );
  }
}
