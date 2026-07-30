import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/dependency_injection.dart';
import '../../domain/entities/search_filters.dart';
import '../bloc/news_search_bloc.dart';
import '../bloc/news_search_event.dart';
import '../controllers/news_search_controller.dart';
import '../widgets/app_header.dart';
import '../widgets/news_results_view.dart';
import '../widgets/search_filters_panel.dart';

class NewsSearchPage extends StatefulWidget {
  const NewsSearchPage({super.key});

  @override
  State<NewsSearchPage> createState() => _NewsSearchPageState();
}

class _NewsSearchPageState extends State<NewsSearchPage> {
  final controller = NewsSearchController();
  int periodHours = 24;
  int maxResults = 10;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _clearSearch(BuildContext blocContext) {
    controller.teams.clear();
    controller.sources.clear();
    controller.keywords.clear();
    setState(() {});
    blocContext.read<NewsSearchBloc>().add(const NewsSearchCleared());
  }

  void _search(BuildContext blocContext) {
    if (controller.teams.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Informe pelo menos um time.')));
      return;
    }
    blocContext.read<NewsSearchBloc>().add(
          NewsSearchRequested(
            SearchFilters(
              teams: List.of(controller.teams),
              sources: controller.sources.isEmpty
                  ? const ['Google']
                  : List.of(controller.sources),
              keywords: List.of(controller.keywords),
              maxResultsPerTeam: maxResults,
              periodHours: periodHours,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<NewsSearchBloc>(),
        child: Builder(
          builder: (context) => Scaffold(
            body: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: AppHeader()),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1180),
                        child: Column(
                          children: [
                            SearchFiltersPanel(
                                controller: controller,
                                periodHours: periodHours,
                                maxResults: maxResults,
                                onPeriodChanged: (value) =>
                                    setState(() => periodHours = value),
                                onMaxResultsChanged: (value) =>
                                    setState(() => maxResults = value),
                                onChanged: () => setState(() {}),
                                onClear: () => _clearSearch(context),
                                onSearch: () => _search(context)),
                            const SizedBox(height: 28),
                            NewsResultsView(
                                onPostStatusChanged: (url) => context
                                    .read<NewsSearchBloc>()
                                    .add(NewsPostStatusChanged(url))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
