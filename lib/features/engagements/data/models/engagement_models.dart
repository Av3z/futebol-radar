import '../../domain/entities/social_post.dart';
import '../../domain/entities/engagement_filters.dart';
import '../../domain/entities/team_engagement.dart';
import '../../../../core/media/media_url.dart';

class EngagementSearchRequestModel {
  const EngagementSearchRequestModel(this.filters);

  final EngagementFilters filters;

  Map<String, dynamic> toJson() => {
        'teams': filters.teams,
        'profiles': filters.profiles,
        'sources': filters.sources,
        'max_results_per_team': filters.maxResultsPerTeam,
        'period_hours': filters.periodHours,
      };
}

class EngagementSearchResponseModel {
  const EngagementSearchResponseModel(this.result);

  final EngagementResult result;

  factory EngagementSearchResponseModel.fromJson(Map<String, dynamic> data) {
    final teams = (data['teams'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map((team) => TeamEngagement(
              team: team['team'] as String,
              posts: (team['posts'] as List<dynamic>? ?? [])
                  .whereType<Map<String, dynamic>>()
                  .map(SocialPostModel.fromJson)
                  .toList(),
            ))
        .toList();
    final warnings = (data['warnings'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map((warning) => EngagementWarning(
              source: warning['source'] as String,
              message: warning['message'] as String,
            ))
        .toList();
    return EngagementSearchResponseModel(EngagementResult(
      requestId: data['request_id'] as String,
      generatedAt: DateTime.parse(data['generated_at'] as String),
      totalResults: data['total_results'] as int,
      teams: teams,
      warnings: warnings,
    ));
  }
}

class SocialPostModel {
  static SocialPost fromJson(Map<String, dynamic> data) => SocialPost(
        id: data['id'] as String,
        team: data['team'] as String,
        platform: data['platform'] as String,
        author: data['author'] as String,
        text: data['text'] as String,
        url: data['url'] as String,
        imageUrl: proxiedImageUrl(data['image_url'] as String?),
        publishedAt: data['published_at'] == null
            ? null
            : DateTime.parse(data['published_at'] as String),
        likes: data['likes'] as int,
        comments: data['comments'] as int,
        shares: data['shares'] as int,
        engagementScore: data['engagement_score'] as int,
      );
}
