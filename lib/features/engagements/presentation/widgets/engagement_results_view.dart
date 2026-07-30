import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../news_search/presentation/widgets/empty_state.dart';
import '../bloc/engagement_bloc.dart';
import '../bloc/engagement_event.dart';
import '../bloc/engagement_state.dart';
import 'social_post_card.dart';

class EngagementResultsView extends StatelessWidget {
  const EngagementResultsView({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<EngagementBloc, EngagementState>(
        builder: (context, state) {
          if (state is EngagementInitial) {
            return const EmptyState(
                icon: Icons.insights_outlined,
                message: 'Configure os filtros para consultar engajamentos.');
          }
          if (state is EngagementLoading) {
            return const Padding(
                padding: EdgeInsets.all(40),
                child: Center(child: CircularProgressIndicator()));
          }
          if (state is EngagementFailure) {
            return EmptyState(
              icon: Icons.cloud_off,
              message: state.message,
              action: state.filters == null
                  ? null
                  : () => context
                      .read<EngagementBloc>()
                      .add(EngagementSearchRetried(state.filters!)),
            );
          }
          final result = switch (state) {
            EngagementSuccess(:final result) => result,
            EngagementEmpty(:final result) => result,
            _ => null,
          };
          if (result == null) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${result.totalResults} posts encontrados',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text('Atualizado em ${result.generatedAt.toLocal()}',
                  style: Theme.of(context).textTheme.bodySmall),
              if (result.warnings.isNotEmpty) ...[
                const SizedBox(height: 14),
                for (final warning in result.warnings)
                  Card(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: ListTile(
                        leading: const Icon(Icons.warning_amber),
                        title: Text(warning.source),
                        subtitle: Text(warning.message)),
                  ),
              ],
              if (result.totalResults == 0)
                const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: EmptyState(
                        icon: Icons.insights_outlined,
                        message: 'Nenhum post encontrado para estes filtros.'))
              else ...[
                const SizedBox(height: 18),
                for (final team in result.teams)
                  if (team.posts.isNotEmpty) ...[
                    Text(team.team,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    for (final post in team.posts) SocialPostCard(post: post),
                    const SizedBox(height: 18),
                  ],
              ],
            ],
          );
        },
      );
}
