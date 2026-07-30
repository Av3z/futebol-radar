import '../../domain/entities/engagement_filters.dart';
import '../../domain/entities/team_engagement.dart';
import '../../domain/repositories/engagement_repository.dart';
import '../datasources/engagement_remote_datasource.dart';

class EngagementRepositoryImpl implements EngagementRepository {
  const EngagementRepositoryImpl(this.datasource);

  final EngagementRemoteDatasource datasource;

  @override
  Future<EngagementResult> search(EngagementFilters filters) =>
      datasource.search(filters).then((model) => model.result);
}
