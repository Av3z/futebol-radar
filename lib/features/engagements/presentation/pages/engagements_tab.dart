import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/dependency_injection.dart';
import '../../../news_search/presentation/controllers/news_search_controller.dart';
import '../../domain/entities/engagement_filters.dart';
import '../bloc/engagement_bloc.dart';
import '../bloc/engagement_event.dart';
import '../widgets/engagement_filters_panel.dart';
import '../widgets/engagement_results_view.dart';

class EngagementsTab extends StatefulWidget {
  const EngagementsTab({super.key});

  @override
  State<EngagementsTab> createState() => _EngagementsTabState();
}

class _EngagementsTabState extends State<EngagementsTab>
    with AutomaticKeepAliveClientMixin<EngagementsTab> {
  final controller = NewsSearchController();
  int periodHours = 24;
  int maxResults = 10;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _clearSearch(BuildContext blocContext) {
    controller.teams.clear();
    controller.profiles.clear();
    controller.sources.clear();
    setState(() {});
    blocContext.read<EngagementBloc>().add(const EngagementSearchCleared());
  }

  void _search(BuildContext blocContext) {
    if (controller.teams.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Informe pelo menos um time.')));
      return;
    }
    blocContext.read<EngagementBloc>().add(EngagementSearchRequested(
          EngagementFilters(
            teams: List.of(controller.teams),
            profiles: List.of(controller.profiles),
            sources: controller.sources.isEmpty
                ? const ['Instagram', 'Facebook', 'X', 'Threads']
                : List.of(controller.sources),
            maxResultsPerTeam: maxResults,
            periodHours: periodHours,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => getIt<EngagementBloc>(),
      child: Builder(
        builder: (context) => CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1180),
                    child: Column(
                      children: [
                        EngagementFiltersPanel(
                          controller: controller,
                          periodHours: periodHours,
                          maxResults: maxResults,
                          onPeriodChanged: (value) =>
                              setState(() => periodHours = value),
                          onMaxResultsChanged: (value) =>
                              setState(() => maxResults = value),
                          onChanged: () => setState(() {}),
                          onClear: () => _clearSearch(context),
                          onSearch: () => _search(context),
                        ),
                        const SizedBox(height: 28),
                        const EngagementResultsView(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
