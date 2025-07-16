import 'package:challenge_eldorado/app/app.dart';
import 'package:challenge_eldorado/bootstrap.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:recommendation_repository/recommendation_repository.dart';

Future<void> main() async {
  await bootstrap(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final client = ElDoradoApiClient.stage();

    final recommendationRepository = RecommendationRepository(client: client);

    return TranslationProvider(
      child: App(recommendationRepository: recommendationRepository),
    );
  });
}
