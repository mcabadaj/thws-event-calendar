import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thws_event_calendar/logic/authentication/authentication_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const MainPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Main Page'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          )),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (context) {
                final user = context.select(
                  (AuthenticationBloc bloc) => bloc.state.user.name,
                );
                return Text('User: $user');
              },
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }
}
