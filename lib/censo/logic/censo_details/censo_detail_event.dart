abstract class CensoDetailEvent {}

class FetchDetailsEvent extends CensoDetailEvent {
  final String nome;
  FetchDetailsEvent({required this.nome});
}