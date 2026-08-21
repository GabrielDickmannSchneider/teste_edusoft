import 'package:flutter/material.dart';
import 'package:teste_edusoft/censo/data/repository/censo_repository.dart';
import 'package:teste_edusoft/censo/presentation/pages/details_page.dart';
import 'package:teste_edusoft/censo/presentation/pages/ranking_page.dart';

class AppRoutes {
  static const String ranking = '/';
  static const String details = '/details';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ranking:
        return MaterialPageRoute(builder: (_) => RankingPage(repo: CensoRepository()));
      case details:
        final nome = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => DetailsPage(repo: CensoRepository(), nome: nome,));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}