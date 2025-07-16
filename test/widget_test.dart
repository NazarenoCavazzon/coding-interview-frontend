import 'package:challenge_eldorado/app/app.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recommendation_repository/recommendation_repository.dart';

void main() {
  group('App', () {
    testWidgets('renders without crashing', (tester) async {
      final client = ElDoradoApiClient.stage();
      final recommendationRepository = RecommendationRepository(client: client);

      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
