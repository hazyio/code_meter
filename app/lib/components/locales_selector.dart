import 'package:flutter/material.dart';
import '../gen/i18n/strings.g.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: Text(t.settingsLanguage),
      subtitle: Text(_displayName(LocaleSettings.currentLocale)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showLanguagePicker(context),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: AppLocaleUtils.supportedLocales.map((locale) {
          final appLocale = AppLocaleUtils.parse(locale.toLanguageTag());
          return ListTile(
            title: Text(_displayName(appLocale)),
            trailing: appLocale == LocaleSettings.currentLocale
                ? const Icon(Icons.check)
                : null,
            onTap: () {
              LocaleSettings.setLocale(appLocale);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  String _displayName(AppLocale locale) {
    switch (locale) {
      case AppLocale.en:
        return 'English';
    }
  }
}
