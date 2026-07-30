import '../repositories/news_repository.dart';

class GetSourcesUsecase {
  const GetSourcesUsecase(this.repository);
  final NewsRepository repository;

  Future<List<String>> call() => repository.getSources();
}
