import 'package:challenge_eldorado/app/app.dart';
import 'package:challenge_eldorado/bootstrap.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

Future<void> main() async {
  await bootstrap(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final client = ElDoradoApiClient.stage();
    await LocaleSettings.setLocale(AppLocale.es);

    return TranslationProvider(child: App(client: client));
  });
}
