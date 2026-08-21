import '../../data/models/censo_details_model.dart';

abstract class CensoDetailState {}

class CensoDetailInitial extends CensoDetailState {}

class CensoDetailLoading extends CensoDetailState {}

class CensoDetailLoaded extends CensoDetailState {
  final String nome;
  final List<CensoDetailsModel> historico;

  CensoDetailLoaded({
    required this.nome,
    required this.historico,
  });

  int get totalOcorrencias =>
      historico.fold(0, (soma, item) => soma + item.frequencia!);
}

class CensoDetailError extends CensoDetailState {
  final String message;
  CensoDetailError(this.message);
}