import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:futebol_radar/core/storage/posted_news_store.dart';
import 'package:futebol_radar/features/news_search/domain/entities/search_filters.dart';
import 'package:futebol_radar/features/news_search/domain/entities/team_news.dart';
import 'package:futebol_radar/features/news_search/domain/repositories/news_repository.dart';
import 'package:futebol_radar/features/news_search/domain/usecases/get_sources_usecase.dart';
import 'package:futebol_radar/features/news_search/domain/usecases/search_news_usecase.dart';
import 'package:futebol_radar/features/news_search/presentation/bloc/news_search_bloc.dart';
import 'package:futebol_radar/features/news_search/presentation/bloc/news_search_event.dart';
import 'package:futebol_radar/features/news_search/presentation/bloc/news_search_state.dart';

class FakeNewsRepository implements NewsRepository {
  FakeNewsRepository(this.result);
  final SearchResult result;

  @override
  Future<SearchResult> search(SearchFilters filters) async => result;

  @override
  Future<List<String>> getSources() async => ['Bolavip'];
}

void main() {
  final filters = SearchFilters(
      teams: ['Santos'],
      sources: ['Bolavip'],
      keywords: [],
      excludedTerms: [],
      maxResultsPerTeam: 10,
      periodHours: 24);

  test('search result keeps dynamic team groups', () {
    final result = SearchResult(
        requestId: 'id',
        generatedAt: DateTime(2026),
        teams: [const TeamNews(team: 'Santos', articles: [])],
        warnings: const [],
        totalResults: 0);
    expect(result.teams.single.team, 'Santos');
  });

  blocTest<NewsSearchBloc, NewsSearchState>(
    'emits loading and success',
    build: () {
      SharedPreferences.setMockInitialValues({});
      final result = SearchResult(
          requestId: 'id',
          generatedAt: DateTime(2026),
          teams: [const TeamNews(team: 'Santos', articles: [])],
          warnings: const [],
          totalResults: 1);
      final repository = FakeNewsRepository(result);
      return NewsSearchBloc(SearchNewsUsecase(repository),
          GetSourcesUsecase(repository), PostedNewsStore());
    },
    act: (bloc) => bloc.add(NewsSearchRequested(filters)),
    expect: () => [const NewsSearchLoading(), isA<NewsSearchSuccess>()],
  );
}
