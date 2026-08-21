abstract class CensoDetailEvent {}

class FetchDetailsEvent extends CensoDetailEvent {
  final String nome;
  final String? sexo;
  final String? localidade;
  FetchDetailsEvent({required this.nome, this.sexo, this.localidade});
}
