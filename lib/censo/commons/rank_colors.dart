import 'dart:ui';

import 'package:teste_edusoft/censo/commons/app_colors.dart';

class RankColors {
  (Color background, Color text) getRankColors(int index) {
  switch (index) {
    case 0: // 1º Lugar - Ouro
      return (AppColors.goldBackground, AppColors.gold);
    case 1: // 2º Lugar - Prata
      return (AppColors.silverBackground, AppColors.silver);
    case 2: // 3º Lugar - Bronze
      return (AppColors.bronzeBackground, AppColors.bronze);
    default: // 4º em diante
      return (AppColors.rankDefaultBackground, AppColors.rankDefault);
  }
}
}