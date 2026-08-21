import 'package:flutter/material.dart';
import '../../../commons/app_colors.dart';

class FilterSectionWidget extends StatelessWidget {
  final String? selectedSexo;
  final String? selectedUf;
  final ValueChanged<String?> onSexoChanged;
  final ValueChanged<String?> onUfChanged;

  const FilterSectionWidget({
    super.key,
    required this.selectedSexo,
    required this.selectedUf,
    required this.onSexoChanged,
    required this.onUfChanged,
  });

  static const Map<String, String> _ufs = {
    'Todos': '',
    'AC': '12', 'AL': '27', 'AP': '16', 'AM': '13', 'BA': '29',
    'CE': '23', 'DF': '53', 'ES': '32', 'GO': '52', 'MA': '21',
    'MT': '51', 'MS': '50', 'MG': '31', 'PA': '15', 'PB': '25',
    'PR': '41', 'PE': '26', 'PI': '22', 'RJ': '33', 'RN': '24',
    'RS': '43', 'RO': '11', 'RR': '14', 'SC': '42', 'SP': '35',
    'SE': '28', 'TO': '17',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String?>(
              value: selectedSexo,
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
              onChanged: onSexoChanged,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: DropdownButtonFormField<String?>(
              value: selectedUf,
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
              onChanged: onUfChanged,
            ),
          ),
        ],
      ),
    );
  }
}