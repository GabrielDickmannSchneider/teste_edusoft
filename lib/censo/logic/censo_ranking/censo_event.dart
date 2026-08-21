abstract class CensoEvent {}

class FetchRankingEvent extends CensoEvent {
  final String? sexo;
  final String? localidade;
  FetchRankingEvent({this.sexo, this.localidade});
}

class ChangePageEvent extends CensoEvent {
  final int page;
  ChangePageEvent(this.page);
}