import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../commons/app_colors.dart';
import '../../commons/rank_colors.dart';
import '../../data/models/censo_nome_model.dart';
import '../../logic/censo_ranking/censo_bloc.dart';
import '../../logic/censo_ranking/censo_event.dart';
import '../../logic/censo_ranking/censo_state.dart';
import 'details_page.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  // Variáveis para guardar o filtro selecionado
  String? _selectedSexo;
  String? _selectedUf;

  // Tabela de UFs do Brasil e seus respectivos códigos no IBGE
  final Map<String, String> _ufs = const {
    'Todos': '',
    'AC': '12',
    'AL': '27',
    'AP': '16',
    'AM': '13',
    'BA': '29',
    'CE': '23',
    'DF': '53',
    'ES': '32',
    'GO': '52',
    'MA': '21',
    'MT': '51',
    'MS': '50',
    'MG': '31',
    'PA': '15',
    'PB': '25',
    'PR': '41',
    'PE': '26',
    'PI': '22',
    'RJ': '33',
    'RN': '24',
    'RS': '43',
    'RO': '11',
    'RR': '14',
    'SC': '42',
    'SP': '35',
    'SE': '28',
    'TO': '17',
  };

  @override
  void initState() {
    super.initState();
    // Faz a chamada inicial para buscar o ranking geral ao abrir a tela
    context.read<CensoBloc>().add(FetchRankingEvent());
  }

  // Dispara a busca com os novos parâmetros selecionados nos filtros
  void _aplicarFiltros() {
    context.read<CensoBloc>().add(
          FetchRankingEvent(
            sexo: _selectedSexo,
            localidade: _selectedUf,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Ranking de Nomes - Censo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. ÁREA DE FILTROS (SEXO E ESTADO)
          _buildFiltrosContainer(),

          // 2. CONTEÚDO PRINCIPAL (ESTADOS DO BLOC)
          Expanded(
            child: BlocBuilder<CensoBloc, CensoState>(
              builder: (context, state) {
                if (state is CensoLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                }

                if (state is CensoFailure) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 56,
                            color: AppColors.error
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.background,
                            ),
                            onPressed: _aplicarFiltros,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Tentar Novamente'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is CensoLoadedState) {
                  if (state.nomesPaginados.isEmpty) {
                    return Center(
                      child: Text(
                        'Nenhum nome encontrado para esses filtros.',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      // Lista dos 10 cards da página atual
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          itemCount: state.nomesPaginados.length,
                          itemBuilder: (context, index) {
                            final item = state.nomesPaginados[index];
                            return _buildNomeCard(item);
                          },
                        ),
                      ),

                      // 3. BARRA DE NAVEGAÇÃO DE PÁGINAS
                      _buildPaginacaoBar(state),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Constrói o cabeçalho de filtros com dropdowns estilizados
  Widget _buildFiltrosContainer() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Dropdown de Sexo
          Expanded(
            child: DropdownButtonFormField<String?>(
              value: _selectedSexo,
              decoration: InputDecoration(
                labelText: 'Sexo',
                labelStyle: TextStyle(color: AppColors.primary),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: const [
                DropdownMenuItem(value: null, child: Text('Todos')),
                DropdownMenuItem(value: 'M', child: Text('Masculino')),
                DropdownMenuItem(value: 'F', child: Text('Feminino')),
              ],
              onChanged: (value) {
                setState(() => _selectedSexo = value);
                _aplicarFiltros();
              },
            ),
          ),
          const SizedBox(width: 12),

          // Dropdown de Estado (UF)
          Expanded(
            child: DropdownButtonFormField<String?>(
              value: _selectedUf,
              decoration: InputDecoration(
                labelText: 'Estado (UF)',
                labelStyle: TextStyle(color: AppColors.primary),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: _ufs.entries.map((entry) {
                return DropdownMenuItem<String?>(
                  value: entry.value.isEmpty ? null : entry.value,
                  child: Text(entry.key),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedUf = value);
                _aplicarFiltros();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Constrói o Card estilizado do nome aplicando as cores de RankColors
  Widget _buildNomeCard(CensoNomeModel item) {
    // Obtém a cor específica de acordo com a posição no ranking (1º, 2º, 3º, etc.)
    final badgeColor = RankColors().getRankColors(item.ranking);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.rankDefaultBackground,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(
          backgroundColor: badgeColor.$1,
          foregroundColor: badgeColor.$2,
          radius: 22,
          child: Text(
            '${item.ranking}º',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        title: Text(
          item.nome,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          '${item.frequencia} registros no Censo',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.primary,
        ),
        onTap: () {
          // Rota para a tela de detalhes com o gráfico histórico
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(nome: item.nome),
            ),
          );
        },
      ),
    );
  }

  /// Constrói a barra de navegação inferior com paginação local
  Widget _buildPaginacaoBar(CensoLoadedState state) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Botão Anterior
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.chevron_left, size: 20),
            label: const Text('Anterior'),
            onPressed: state.currentPage > 1
                ? () {
                    context.read<CensoBloc>().add(
                          ChangePageEvent(state.currentPage - 1),
                        );
                  }
                : null,
          ),

          // Texto com a contagem de páginas
          Text(
            'Página ${state.currentPage} de ${state.totalPages}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),

          // Botão Próxima
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.chevron_right, size: 20),
            label: const Text('Próxima'),
            onPressed: state.currentPage < state.totalPages
                ? () {
                    context.read<CensoBloc>().add(
                          ChangePageEvent(state.currentPage + 1),
                        );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}