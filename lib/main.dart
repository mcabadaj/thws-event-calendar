import 'package:flutter/material.dart';
import 'package:system_theme/system_theme.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemTheme.fallbackColor = Colors.orange.shade600;
  await SystemTheme.accentColor.load();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
