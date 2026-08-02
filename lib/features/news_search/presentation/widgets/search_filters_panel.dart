import 'package:flutter/material.dart';

import '../controllers/news_search_controller.dart';
import 'tag_input_field.dart';
import 'team_suggestions.dart';

class SearchFiltersPanel extends StatelessWidget {
  const SearchFiltersPanel(
      {super.key,
      required this.controller,
      required this.periodHours,
      required this.maxResults,
      required this.onPeriodChanged,
      required this.onMaxResultsChanged,
      required this.onSearch,
      required this.onClear,
      required this.onChanged});
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
              Text('Configurar pesquisa',
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
                  onChanged: onChanged),
              const SizedBox(height: 12),
              TagInputField(
                  controller: controller,
                  field: controller.source,
                  values: controller.sources,
                  label: 'Fontes (opcional)',
                  hint: 'Google por padrão',
                  icon: Icons.public,
                  suggestions: const [
                    'Google',
                    'Yahoo',
                    'Bolavip',
                    'Antenados no Futebol',
                    'Somos Fanáticos'
                  ],
                  onChanged: onChanged),
              const SizedBox(height: 12),
              TagInputField(
                  controller: controller,
                  field: controller.keyword,
                  values: controller.keywords,
                  label: 'Palavras-chave',
                  hint: 'Futebol é padrão. Ex.: mercado da bola',
                  icon: Icons.sell_outlined,
                  onChanged: onChanged),
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
                              value: value, child: Text('$value notícias'))
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
                          label: const Text('Buscar notícias'))),
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
