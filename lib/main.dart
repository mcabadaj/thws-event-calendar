import 'package:flutter/material.dart';
import 'package:thws_event_calendar/presentation/pages/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: LoginPage(),
        ),
      ),
    );
  }
}
