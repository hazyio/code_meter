import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/pages/analytics/page.dart';
import 'package:code_meter/pages/home/page.dart';
import 'package:code_meter/pages/settings/page.dart';
import 'package:code_meter/pages/welcome/page.dart';
import 'package:code_meter/theme/app_theme.dart';
import 'package:code_meter/utils/settings_repository.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  final hasSettings = await SettingsStorage.settingSaved();
  final startRoute = hasSettings ? '/home' : '/welcome';

  runApp(TranslationProvider(child: MyApp(initialRoute: startRoute)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'Code Meter',
          theme: AppTheme.light(dynamicScheme: lightDynamic),
          darkTheme: AppTheme.dark(dynamicScheme: darkDynamic),
          themeMode: ThemeMode.system,
          initialRoute: initialRoute,
          routes: {
            '/home': (context) => const HomePage(),
            '/welcome': (context) => const WelcomePage(),
            '/settings': (context) => const SettingsPage(),
            "/analytics": (context) => const AnalyticsPage(),
          },
        );
      },
    );
  }
}
