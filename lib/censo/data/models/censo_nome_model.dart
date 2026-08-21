class CensoNomeModel {
  static const String kNome = 'nome';
  static const String kFrequencia = 'frequencia';
  static const String kRanking = 'ranking';

  final String nome;
  final int frequencia;
  final int ranking;

  CensoNomeModel({
    required this.nome,
    required this.frequencia,
    required this.ranking,
  });

  factory CensoNomeModel.fromJson(Map<String, dynamic> json) {
    return CensoNomeModel(
      nome: json[kNome], 
      frequencia: json[kFrequencia], 
      ranking: json[kRanking]
    );
  }
}