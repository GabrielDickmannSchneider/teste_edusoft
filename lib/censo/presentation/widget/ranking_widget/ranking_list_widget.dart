import 'package:flutter/material.dart';
import 'package:teste_edusoft/censo/data/models/censo_nome_model.dart';
import 'ranking_card_widget.dart';

class RankingListWidget extends StatelessWidget {
 final List<CensoNomeModel> nomes;
  final String? sexo;
  final String? localidade;

  const RankingListWidget({
    super.key,
    required this.nomes,
    this.sexo,
    this.localidade,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: nomes.length,
      itemBuilder: (context, index) {
        return RankingCardWidget(
          item: nomes[index],
          sexo: sexo,
          localidade: localidade,
        );
      },
    );
  }
}