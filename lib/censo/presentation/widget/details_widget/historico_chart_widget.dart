import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:teste_edusoft/censo/commons/app_colors.dart';
import 'package:teste_edusoft/censo/data/models/censo_details_model.dart';

class HistoricoChartWidget extends StatelessWidget {
  final List<CensoDetailsModel> historico;

  const HistoricoChartWidget({super.key, required this.historico});

  @override
  Widget build(BuildContext context) {
    // Transforma a lista de períodos em coordenadas (X, Y) para o fl_chart
    final List<FlSpot> spots = historico.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value.frequencia!.toDouble(),
      );
    }).toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Frequência por Década',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  // Eixo inferior: formatação das décadas (ex.: [1930,1940[ -> 1930)
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < historico.length) {
                          final label = historico[index]
                              .periodo!
                              .replaceAll(RegExp(r'[\[\]]'), '');
                          final textoDecada = label.length >= 4
                              ? label.substring(0, 4)
                              : label;

                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              textoDecada,
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: (AppColors.primary)
                          .withOpacity(0.15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}