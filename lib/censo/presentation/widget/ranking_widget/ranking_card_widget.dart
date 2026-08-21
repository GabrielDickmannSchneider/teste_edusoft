import 'package:flutter/material.dart';
import 'package:teste_edusoft/censo/commons/app_colors.dart';
import 'package:teste_edusoft/censo/commons/rank_colors.dart';
import 'package:teste_edusoft/censo/data/models/censo_nome_model.dart';
import 'package:teste_edusoft/censo/presentation/pages/details_page.dart';

class RankingCardWidget extends StatelessWidget {
  final CensoNomeModel item;
  final String? sexo;
  final String? localidade;

  const RankingCardWidget({
    super.key,
    required this.item,
    this.sexo,
    this.localidade,
  });

  @override
  Widget build(BuildContext context) {
    final badgeColor = RankColors().getRankColors(item.ranking);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.background,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(
          backgroundColor: badgeColor.$1,
          foregroundColor: badgeColor.$2,
          radius: 22,
          child: Text(
            '${item.ranking}º',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        title: Text(
          item.nome,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          '${item.frequencia} registros no Censo',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.primary,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                nome: item.nome,
                sexo: sexo,
                localidade: localidade,
              ),
            ),
          );
        },
      ),
    );
  }
}