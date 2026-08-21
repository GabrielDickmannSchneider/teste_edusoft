import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/censo/commons/app_colors.dart';
import 'package:teste_edusoft/censo/logic/censo_ranking/censo_bloc.dart';
import 'package:teste_edusoft/censo/logic/censo_ranking/censo_event.dart';
import 'package:teste_edusoft/censo/logic/censo_ranking/censo_state.dart';
import 'package:teste_edusoft/censo/presentation/widget/ranking_widget/feedback_views.dart';
import 'package:teste_edusoft/censo/presentation/widget/ranking_widget/filter_section_widget.dart';
import 'package:teste_edusoft/censo/presentation/widget/ranking_widget/pagination_bar_widget.dart';
import 'package:teste_edusoft/censo/presentation/widget/ranking_widget/ranking_list_widget.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  String? _selectedSexo;
  String? _selectedUf;

  @override
  void initState() {
    super.initState();
    _carregarRanking();
  }

  void _carregarRanking() {
    context.read<CensoBloc>().add(
      FetchRankingEvent(sexo: _selectedSexo, localidade: _selectedUf),
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
          FilterSectionWidget(
            selectedSexo: _selectedSexo,
            selectedUf: _selectedUf,
            onSexoChanged: (novoSexo) {
              setState(() => _selectedSexo = novoSexo);
              _carregarRanking();
            },
            onUfChanged: (novaUf) {
              setState(() => _selectedUf = novaUf);
              _carregarRanking();
            },
          ),

          Expanded(
            child: BlocBuilder<CensoBloc, CensoState>(
              builder: (context, state) {
                if (state is CensoLoading) {
                  return const LoadingView();
                }

                if (state is CensoFailure) {
                  return ErrorView(
                    message: state.message,
                    onRetry: _carregarRanking,
                  );
                }

                if (state is CensoLoadedState) {
                  if (state.nomesPaginados.isEmpty) {
                    return const EmptyView();
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: RankingListWidget(
                          nomes: state.nomesPaginados,
                          sexo: state.sexo,
                          localidade: state.localidade,
                        ),
                      ),

                      PaginationBarWidget(
                        currentPage: state.currentPage,
                        totalPages: state.totalPages,
                        onPageChanged: (novaPagina) {
                          context.read<CensoBloc>().add(
                            ChangePageEvent(novaPagina),
                          );
                        },
                      ),
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
}
