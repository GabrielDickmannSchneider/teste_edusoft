import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/censo/commons/app_colors.dart';
import 'package:teste_edusoft/censo/data/repository/censo_repository.dart';
import 'package:teste_edusoft/censo/logic/censo_details/censo_detail_bloc.dart';
import 'package:teste_edusoft/censo/logic/censo_details/censo_detail_event.dart';
import 'package:teste_edusoft/censo/logic/censo_details/censo_detail_state.dart';
import 'package:teste_edusoft/censo/presentation/widget/details_widget/details_header_widget.dart';
import 'package:teste_edusoft/censo/presentation/widget/details_widget/historico_chart_widget.dart';
import 'package:teste_edusoft/censo/presentation/widget/ranking_widget/feedback_views.dart';

class DetailsPage extends StatelessWidget {
  final String nome;
  final String? sexo;
  final String? localidade;

  const DetailsPage({
    super.key,
    required this.nome,
    this.sexo,
    this.localidade,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CensoDetailBloc>(
      create: (context) => CensoDetailBloc(repo: CensoRepository())
        ..add(FetchDetailsEvent(
          nome: nome,
          sexo: sexo,
          localidade: localidade,
        )),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'Detalhes: $nome',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
          elevation: 0,
        ),
        body: BlocBuilder<CensoDetailBloc, CensoDetailState>(
          builder: (context, state) {
            if (state is CensoDetailLoading) {
              return const LoadingView();
            }

            if (state is CensoDetailError) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<CensoDetailBloc>().add(FetchDetailsEvent(
                        nome: nome,
                        sexo: sexo,
                        localidade: localidade,
                      ));
                },
              );
            }

            if (state is CensoDetailLoaded) {
              if (state.historico.isEmpty) {
                return const EmptyView();
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DetailsHeaderWidget(
                      nome: state.nome,
                      totalRegistros: state.totalOcorrencias,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: HistoricoChartWidget(
                        historico: state.historico,
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}