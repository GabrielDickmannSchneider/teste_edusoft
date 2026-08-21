import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/censo/data/repository/censo_repository.dart';
import 'package:teste_edusoft/censo/logic/censo_details/censo_detail_event.dart';
import 'package:teste_edusoft/censo/logic/censo_details/censo_detail_state.dart';

class CensoDetailBloc extends Bloc<CensoDetailEvent, CensoDetailState> {
  final CensoRepository repo;
  CensoDetailBloc({required this.repo}) : super(CensoDetailInitial()) {
    on<FetchDetailsEvent>(_onFetchDetails);
  }

  Future<void> _onFetchDetails(FetchDetailsEvent event, Emitter<CensoDetailState> emit) async {
    emit(CensoDetailLoading());
    try {
      final periodos = await repo.getDetails(event.nome);
      emit(CensoDetailSucess(periodos: periodos));
    } catch (e) {
      emit(CensoDetailFailure(message: e.toString()));
    }
  }
}