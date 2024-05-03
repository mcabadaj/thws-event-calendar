import 'package:flutter/material.dart';

class _FormRow extends StatelessWidget {
  final Widget left;
  final Widget right;

  const _FormRow(
    this.left,
    this.right, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          left,
          right,
        ],
      ),
    );
  }
}

class UsernameRow extends StatelessWidget {
  final TextEditingController? controller;

  const UsernameRow({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return _FormRow(
      Container(
        padding: const EdgeInsets.all(8.0),
        child: const Text(
          'Username',
          textAlign: TextAlign.right,
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 30,
        child: TextFormField(
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                !RegExp(r'^k\d{5}$').hasMatch(value)) {
              return 'Please enter a valid k-number';
            }
            return null;
          },
          textAlign: TextAlign.left,
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

class PasswordRow extends StatelessWidget {
  final TextEditingController? controller;

  const PasswordRow({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return _FormRow(
      Container(
        padding: const EdgeInsets.all(8.0),
        child: const Text(
          'Password',
          textAlign: TextAlign.right,
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 30,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            return null;
          },
          textAlign: TextAlign.left,
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

class RememberMeRow extends StatefulWidget {
  const RememberMeRow({
    super.key,
  });

  @override
  State<RememberMeRow> createState() => _RememberMeRowState();
}

class _RememberMeRowState extends State<RememberMeRow> {
  bool shouldRemember = false;

  @override
  Widget build(BuildContext context) {
    return _FormRow(
      const Text('Remember me:'),
      Checkbox(
        value: shouldRemember,
        onChanged: (val) => setState(
          () {
            shouldRemember = val!;
          },
        ),
      ),
    );
  }
}
