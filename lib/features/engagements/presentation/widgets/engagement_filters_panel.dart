import 'package:flutter/material.dart';

import '../../../news_search/presentation/controllers/news_search_controller.dart';
import '../../../news_search/presentation/widgets/tag_input_field.dart';
import '../../../news_search/presentation/widgets/team_suggestions.dart';

class EngagementFiltersPanel extends StatelessWidget {
  const EngagementFiltersPanel({
    super.key,
    required this.controller,
    required this.periodHours,
    required this.maxResults,
    required this.onPeriodChanged,
    required this.onMaxResultsChanged,
    required this.onSearch,
    required this.onClear,
    required this.onChanged,
  });

  final NewsSearchController controller;
  final int periodHours;
  final int maxResults;
  final ValueChanged<int> onPeriodChanged;
  final ValueChanged<int> onMaxResultsChanged;
  final VoidCallback onSearch;
  final VoidCallback onClear;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Configurar engajamentos',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              TagInputField(
                controller: controller,
                field: controller.team,
                values: controller.teams,
                label: 'Times',
                hint: 'Ex.: Santos',
                icon: Icons.groups_outlined,
                suggestions: teamSuggestions,
                onChanged: onChanged,
              ),
              const SizedBox(height: 12),
              TagInputField(
                controller: controller,
                field: controller.profile,
                values: controller.profiles,
                label: 'UsuÃ¡rios / perfis (opcional)',
                hint: '@santosfc ou nome do perfil',
                icon: Icons.person_search_outlined,
                onChanged: onChanged,
              ),
              const SizedBox(height: 12),
              TagInputField(
                controller: controller,
                field: controller.source,
                values: controller.sources,
                label: 'Redes sociais (opcional)',
                hint: 'Todas as redes por padrão',
                icon: Icons.share_outlined,
                suggestions: const ['Instagram', 'Facebook', 'X', 'Threads'],
                onChanged: onChanged,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      initialValue: periodHours,
                      decoration: const InputDecoration(
                          labelText: 'Período', border: OutlineInputBorder()),
                      items: const [
                        DropdownMenuItem(
                            value: 2, child: Text('Últimas 2 horas')),
                        DropdownMenuItem(
                            value: 4, child: Text('Últimas 4 horas')),
                        DropdownMenuItem(
                            value: 8, child: Text('Últimas 8 horas')),
                        DropdownMenuItem(
                            value: 24, child: Text('Últimas 24 horas')),
                        DropdownMenuItem(
                            value: 48, child: Text('Últimos 2 dias')),
                        DropdownMenuItem(
                            value: 72, child: Text('Últimos 3 dias')),
                        DropdownMenuItem(
                            value: 168, child: Text('Últimos 7 dias')),
                      ],
                      onChanged: (value) {
                        if (value != null) onPeriodChanged(value);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 130,
                    child: DropdownButtonFormField<int>(
                      initialValue: maxResults,
                      decoration: const InputDecoration(
                          labelText: 'Máx.', border: OutlineInputBorder()),
                      items: [
                        for (final value in [5, 10, 20, 50])
                          DropdownMenuItem(
                              value: value, child: Text('$value posts'))
                      ],
                      onChanged: (value) {
                        if (value != null) onMaxResultsChanged(value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                        onPressed: onSearch,
                        icon: const Icon(Icons.search),
                        label: const Text('Buscar engajamentos')),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                      onPressed: onClear, child: const Text('Limpar')),
                ],
              ),
            ],
          ),
        ),
      );
}
