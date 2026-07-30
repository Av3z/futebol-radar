import '../../domain/entities/search_filters.dart';
import '../../domain/entities/team_news.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  const NewsRepositoryImpl(this.datasource);
  final NewsRemoteDatasource datasource;

  @override
  Future<SearchResult> search(SearchFilters filters) =>
      datasource.search(filters).then((model) => model.result);

  @override
  Future<List<String>> getSources() => datasource.getSources();
}
