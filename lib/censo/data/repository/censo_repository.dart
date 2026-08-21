import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teste_edusoft/censo/data/models/censo_details_model.dart';
import 'package:teste_edusoft/censo/data/models/censo_nome_model.dart';

class CensoRepository {
  static const String baseUrl = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes';

  Future<List<CensoNomeModel>> getRanking({String? sexo, String? localidade}) async {
    final Map<String, String> queryParams = {};
    if (sexo != null && sexo.isNotEmpty) queryParams['sexo'] = sexo;
    if (localidade != null && localidade.isNotEmpty) queryParams['localidade'] = localidade;

    final url = Uri.parse('$baseUrl/ranking').replace(queryParameters: queryParams.isEmpty ? null : queryParams);
    return await http.get(url).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> result = jsonDecode(response.body);
        List<dynamic> resList = result.first['res'];
        return resList.map((r) => CensoNomeModel.fromJson(r)).toList();
      }
      throw Exception(response.body);
    });
  }

  Future<List<CensoDetailsModel>> getDetails(String nome) async {
    final url = Uri.parse('$baseUrl/${Uri.encodeComponent(nome)}');
    return await http.get(url).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> result = jsonDecode(response.body);
        List<dynamic> resList = result.first['res'];
        return resList.map((r) => CensoDetailsModel.fromJson(r)).toList();
      }
      throw Exception(response.body);
    });
  }
}