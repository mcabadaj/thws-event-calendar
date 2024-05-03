import 'package:flutter/material.dart';
import 'package:thws_event_calendar/presentation/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool shouldRemember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login Page'),
              const UsernameRow(),
              const PasswordRow(),
              const RememberMeRow(),
              FilledButton(
                onPressed: () => {},
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
