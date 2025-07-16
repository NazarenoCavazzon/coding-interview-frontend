import 'package:challenge_eldorado/app/app.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders without crashing', (tester) async {
      final client = ElDoradoApiClient.stage();

      await tester.pumpWidget(App(client: client));

      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
