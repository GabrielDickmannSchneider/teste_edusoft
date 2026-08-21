import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/censo/data/repository/censo_repository.dart';
import 'package:teste_edusoft/censo/logic/censo_ranking/censo_bloc.dart';
import 'package:teste_edusoft/censo/presentation/pages/details_page.dart';
import 'package:teste_edusoft/censo/presentation/pages/ranking_page.dart';

class AppRoutes {
  static const String ranking = '/';
  static const String details = '/details';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final repo = CensoRepository();

    switch (settings.name) {
      case ranking:
        return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (_) => CensoBloc(repo: repo),
            child: const RankingPage(),
          ));
      case details:
        final nome = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => DetailsPage(nome: nome,));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}