import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendation_repository/recommendation_repository.dart';

class App extends StatelessWidget {
  const App({required this.client, super.key});

  final ElDoradoApiClient client;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RecommendationRepository(client: client),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Challenge Eldorado',
      home: SizedBox(),
    );
  }
}
