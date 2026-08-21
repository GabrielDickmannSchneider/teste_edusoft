import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teste_edusoft/censo/data/models/censo_details_model.dart';
import 'package:teste_edusoft/censo/data/models/censo_nome_model.dart';

class CensoRepository {
  Future<List<CensoNomeModel>> getRanking(int? page) async {
    Map<String, dynamic> query = {};
    if (page != null) query['page'] = page.toString();
    Uri url = Uri.https('servicodados.ibge.gov.br','/api/v2/censos/nomes/ranking',query);
    return await http.get(url).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> result = jsonDecode(response.body);
        List<dynamic> resList = result.first['res'];
        return resList.map((r) => CensoNomeModel.fromJson(r)).toList();
      }
      throw Exception(response.body);
    });
  }

  Future<List<CensoDetailsModel>> getDetails(String? nome) async {
    Uri url = Uri.parse('https://servicodados.ibge.gov.br/api/v2/censos/nomes/$nome');
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