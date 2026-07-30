import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/search_filters.dart';
import '../bloc/news_search_bloc.dart';
import '../bloc/news_search_event.dart';
import '../bloc/news_search_state.dart';
import 'dynamic_team_tabs.dart';
import 'empty_state.dart';

class NewsResultsView extends StatelessWidget {
  const NewsResultsView({super.key, required this.onPostStatusChanged});
  final ValueChanged<String> onPostStatusChanged;

  @override
  Widget build(BuildContext context) => BlocBuilder<NewsSearchBloc, NewsSearchState>(
        builder: (context, state) {
          if (state is NewsSearchInitial || state is SourcesLoaded) {
            return const EmptyState(icon: Icons.search, message: 'Configure os filtros para começar uma pesquisa.');
          }
          if (state is NewsSearchLoading) {
            return const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator()));
          }
          if (state is NewsSearchEmpty) {
            return const EmptyState(icon: Icons.article_outlined, message: 'Nenhuma notícia encontrada para estes filtros.');
          }
          if (state is NewsSearchFailure) {
            return EmptyState(
              icon: Icons.cloud_off,
              message: state.message,
              action: state.filters is SearchFilters ? () => context.read<NewsSearchBloc>().add(NewsSearchRetried(state.filters!)) : null,
            );
          }
          final result = (state as NewsSearchSuccess).result;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${result.totalResults} notícias encontradas',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              Text('Atualizado em ${result.generatedAt.toLocal()}', style: Theme.of(context).textTheme.bodySmall),
              if (result.warnings.isNotEmpty) ...[
                const SizedBox(height: 14),
                for (final warning in result.warnings)
                  Card(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: ListTile(leading: const Icon(Icons.warning_amber), title: Text(warning.source), subtitle: Text(warning.message)),
                  ),
              ],
              const SizedBox(height: 18),
              DynamicTeamTabs(teams: result.teams, onPostStatusChanged: onPostStatusChanged),
            ],
          );
        },
      );
}
