import '../entities/search_filters.dart';
import '../entities/team_news.dart';
import '../repositories/news_repository.dart';

class SearchNewsUsecase {
  const SearchNewsUsecase(this.repository);
  final NewsRepository repository;

  Future<SearchResult> call(SearchFilters filters) =>
      repository.search(filters);
}
