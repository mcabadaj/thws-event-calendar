import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thws_event_calendar/logic/login/login_bloc.dart';
import 'package:thws_event_calendar/util/validators/login_validator.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          return Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Login Page'),
                  _UsernameRow(controller: usernameController),
                  _PasswordRow(controller: passwordController),
                  if (state is LoginFailure)
                    Text(
                      state.message,
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  const _RememberMeRow(),
                  switch (state) {
                    ValidatingLogin() => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const CircularProgressIndicator(),
                            Text(
                              'Logging in...',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    _ => LoginButton(
                        usernameController: usernameController,
                        passwordController: passwordController),
                  }
                ],
              ),
            ),
          );
        });
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (Form.of(context).validate()) {
          context.read<LoginBloc>().add(
                ValidateLogin(
                  usernameController.text,
                  passwordController.text,
                ),
              );
        }
      },
      child: const Text('LOGIN'),
    );
  }
}

class _UsernameRow extends StatelessWidget {
  final TextEditingController controller;

  const _UsernameRow({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextFormField(
        maxLines: 1,
        controller: controller,
        validator: LoginValidator.validateUsername,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: 'k-Number',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _PasswordRow extends StatelessWidget {
  final TextEditingController controller;

  const _PasswordRow({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextFormField(
        maxLines: 1,
        textAlign: TextAlign.left,
        obscureText: true,
        controller: controller,
        validator: LoginValidator.validatePassword,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.key),
          labelText: 'Password',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _RememberMeRow extends StatefulWidget {
  const _RememberMeRow({
    super.key,
  });

  @override
  State<_RememberMeRow> createState() => _RememberMeRowState();
}

class _RememberMeRowState extends State<_RememberMeRow> {
  bool shouldRemember = false;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Remember me:'),
      Checkbox(
        value: shouldRemember,
        onChanged: (val) => setState(
          () {
            shouldRemember = val!;
          },
        ),
      ),
    ]);
  }
}
