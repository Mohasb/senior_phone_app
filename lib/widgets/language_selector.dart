import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  final List<Locale> supportedLocales = [
  const Locale('en', 'US'),
  const Locale('es', 'ES'),
];

  LanguageSelector({required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      onChanged: (Locale? locale) {
        if (locale != null) {
          onLocaleChange(locale);
        }
      },
      items: supportedLocales.map((locale) {
        return DropdownMenuItem<Locale>(
          value: locale,
          child: Text(locale.languageCode == 'en' ? 'English' : 'Español'),
        );
      }).toList(),
      hint: Text('Select Language'),
    );
  }
}
