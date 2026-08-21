import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/censo/data/repository/censo_repository.dart';
import 'package:teste_edusoft/censo/logic/censo_ranking/censo_event.dart';
import 'package:teste_edusoft/censo/logic/censo_ranking/censo_state.dart';

class CensoBloc extends Bloc<CensoEvent, CensoState> {
  final CensoRepository repo;
  static const int pageSize = 10;

  CensoBloc({required this.repo}) : super(CensoInitial()) {
    on<FetchRankingEvent>(_onFetchRanking);
    on<ChangePageEvent>(_onChangePage);
  }

  Future<void> _onFetchRanking(
    FetchRankingEvent event,
    Emitter<CensoState> emit,
  ) async {
    emit(CensoLoading());
    try {
      final nomes = await repo.getRanking(
        sexo: event.sexo,
        localidade: event.localidade,
      );

      final totalPages = (nomes.length / pageSize).ceil();
      final paginados = nomes.take(pageSize).toList();

      emit(
        CensoLoadedState(
          todosNomes: nomes,
          nomesPaginados: paginados,
          currentPage: 1,
          totalPages: totalPages > 0 ? totalPages : 1,
          sexo: event.sexo,
          localidade: event.localidade,
        ),
      );
    } catch (e) {
      emit(CensoFailure(message: e.toString()));
    }
  }

  Future<void> _onChangePage(
    ChangePageEvent event,
    Emitter<CensoState> emit,
  ) async {
    if (state is CensoLoadedState) {
      final currentState = state as CensoLoadedState;
      final newPage = event.page;
      if (newPage < 1 || newPage > currentState.totalPages) return;

      final startIndex = (newPage - 1) * pageSize;
      final paginados = currentState.todosNomes
          .skip(startIndex)
          .take(pageSize)
          .toList();

      emit(
        CensoLoadedState(
          todosNomes: currentState.todosNomes,
          nomesPaginados: paginados,
          currentPage: newPage,
          totalPages: currentState.totalPages,
          sexo: currentState.sexo,
          localidade: currentState.localidade,
        ),
      );
    }
  }
}
