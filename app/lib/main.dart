import 'package:code_meter/pages/home/page.dart';
import 'package:code_meter/pages/settings/page.dart';
import 'package:code_meter/pages/welcome/page.dart';
import 'package:code_meter/theme/app_theme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'Code Meter',
          theme: AppTheme.light(dynamicScheme: lightDynamic),
          darkTheme: AppTheme.dark(dynamicScheme: darkDynamic),
          themeMode: ThemeMode.system,
          initialRoute: '/welcome',
          routes: {
            '/': (context) => const HomePage(),
            '/welcome': (context) => const WelcomePage(),
            '/settings': (context) => const SettingsPage(),
          },
        );
      },
    );
  }
}
