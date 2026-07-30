import '../entities/search_filters.dart';
import '../entities/team_news.dart';

abstract interface class NewsRepository {
  Future<SearchResult> search(SearchFilters filters);
  Future<List<String>> getSources();
}
