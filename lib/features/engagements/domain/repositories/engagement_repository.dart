import '../entities/engagement_filters.dart';
import '../entities/team_engagement.dart';

abstract interface class EngagementRepository {
  Future<EngagementResult> search(EngagementFilters filters);
}
