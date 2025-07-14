import 'package:challenge_eldorado/app/app.dart';
import 'package:challenge_eldorado/bootstrap.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await bootstrap(() async {
    WidgetsFlutterBinding.ensureInitialized();

    return App(client: ElDoradoApiClient.stage());
  });
}
