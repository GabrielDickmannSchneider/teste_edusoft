import 'package:teste_edusoft/censo/data/models/censo_nome_model.dart';

abstract class CensoState {}

class CensoInitial extends CensoState {}

class CensoLoading extends CensoState {}

class CensoLoadedState extends CensoState {
  final List<CensoNomeModel> todosNomes;
  final List<CensoNomeModel> nomesPaginados;
  final int currentPage;
  final int totalPages;
  final String? sexo;
  final String? localidade;

  CensoLoadedState({
    required this.todosNomes,
    required this.nomesPaginados,
    required this.currentPage,
    required this.totalPages,
    this.sexo,
    this.localidade,
  });
}

class CensoFailure extends CensoState {
  final String message;

  CensoFailure({required this.message});
}