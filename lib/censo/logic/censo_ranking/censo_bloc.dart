import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/censo/data/models/censo_nome_model.dart';
import 'package:teste_edusoft/censo/data/repository/censo_repository.dart';
import 'package:teste_edusoft/censo/logic/censo_ranking/censo_event.dart';
import 'package:teste_edusoft/censo/logic/censo_ranking/censo_state.dart';

class CensoBloc extends Bloc<CensoEvent, CensoState> {
  final CensoRepository repo;
  int _page = 1;

  CensoBloc({required this.repo}) : super(CensoInitial()) {
    on<FetchRankingEvent>(_onFetchRanking);
  }

  Future<void> _onFetchRanking(
    FetchRankingEvent event,
    Emitter<CensoState> emit,
  ) async {
    final itensAntigos = state is CensoSucess
        ? (state as CensoSucess).ranking
        : <CensoNomeModel>[];

    if (itensAntigos.isEmpty) emit(CensoLoading());

    try {
      final novosItens = await repo.getRanking(_page);
      if (novosItens.isEmpty) {
        emit(CensoSucess(ranking: novosItens, hasReachedMax: true));
        return;
      }

      _page++;
      emit(CensoSucess(
        ranking: [...itensAntigos, ...novosItens],
        hasReachedMax: false,
      ));
    } catch (e) {
      emit(CensoFailure(message: e.toString()));
    }
  }
}
