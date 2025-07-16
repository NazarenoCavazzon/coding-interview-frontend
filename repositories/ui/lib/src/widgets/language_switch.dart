import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: _toggleLanguage,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                _getCurrentLanguageLabel(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getCurrentLanguageLabel() {
    return LocaleSettings.currentLocale.languageCode.toUpperCase();
  }

  void _toggleLanguage() {
    final newLocale = LocaleSettings.currentLocale == AppLocale.en
        ? AppLocale.es
        : AppLocale.en;
    LocaleSettings.setLocale(newLocale);
  }
}
