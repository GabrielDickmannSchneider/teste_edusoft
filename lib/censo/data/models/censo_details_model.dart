class CensoDetailsModel {
  static const String kPeriodo = 'periodo';
  static const String kFrequencia = 'frequencia';

  final String? periodo;
  final int? frequencia;

  CensoDetailsModel({
    this.periodo,
    this.frequencia
  });

  factory CensoDetailsModel.fromJson(Map<String, dynamic> json) {
    return CensoDetailsModel(
      periodo: json[kPeriodo].replaceAll('[','').replaceAll(']','').replaceAll(',',' até '),
      frequencia: json[kFrequencia]
    );
  }
}