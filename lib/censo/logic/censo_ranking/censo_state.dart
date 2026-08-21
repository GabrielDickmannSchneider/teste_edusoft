import 'package:teste_edusoft/censo/data/models/censo_nome_model.dart';

abstract class CensoState {}

class CensoInitial extends CensoState {}

class CensoLoading extends CensoState {}

class CensoSucess extends CensoState {
  final List<CensoNomeModel> ranking;
  final bool hasReachedMax;

  CensoSucess({required this.ranking, required this.hasReachedMax});
}

class CensoFailure extends CensoState {
  final String message;

  CensoFailure({required this.message});
}