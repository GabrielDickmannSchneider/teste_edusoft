
import 'package:teste_edusoft/censo/data/models/censo_details_model.dart';

abstract class CensoDetailState {}

class CensoDetailInitial extends CensoDetailState {}

class CensoDetailLoading extends CensoDetailState {}

class CensoDetailSucess extends CensoDetailState {
  final List<CensoDetailsModel> periodos;

  CensoDetailSucess({required this.periodos});
}

class CensoDetailFailure extends CensoDetailState {
  final String message;

  CensoDetailFailure({required this.message});
}