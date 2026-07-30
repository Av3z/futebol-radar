import '../entities/engagement_filters.dart';
import '../entities/team_engagement.dart';
import '../repositories/engagement_repository.dart';

class SearchEngagementUsecase {
  const SearchEngagementUsecase(this.repository);

  final EngagementRepository repository;

  Future<EngagementResult> call(EngagementFilters filters) =>
      repository.search(filters);
}
