import '../../domain/entities/news_article.dart';
import '../../domain/entities/search_filters.dart';
import '../../domain/entities/team_news.dart';
import '../../../../core/media/media_url.dart';

class NewsSearchRequestModel {
  const NewsSearchRequestModel(this.filters);
  final SearchFilters filters;

  Map<String, dynamic> toJson() => {
        'teams': filters.teams,
        'sources': filters.sources,
        'keywords': filters.keywords,
        'excluded_terms': filters.excludedTerms,
        'max_results_per_team': filters.maxResultsPerTeam,
        'period_hours': filters.periodHours
      };
}

class NewsSearchResponseModel {
  const NewsSearchResponseModel(this.result);
  final SearchResult result;

  factory NewsSearchResponseModel.fromJson(Map<String, dynamic> json) {
    final teams = (json['teams'] as List<dynamic>? ?? []).map((item) {
      final map = item as Map<String, dynamic>;
      final articles = (map['articles'] as List<dynamic>? ?? []).map((raw) {
        final data = raw as Map<String, dynamic>;
        return NewsArticle(
            id: data['id'] as String,
            title: data['title'] as String,
            summary: data['summary'] as String? ?? '',
            team: data['team'] as String,
            source: data['source'] as String,
            url: data['url'] as String,
            imageUrl: proxiedImageUrl(data['image_url'] as String?),
            publishedAt: data['published_at'] == null
                ? null
                : DateTime.tryParse(data['published_at'] as String),
            publishedAtVerified:
                data['published_at_verified'] as bool? ?? false,
            matchedKeywords: (data['matched_keywords'] as List<dynamic>? ?? [])
                .cast<String>(),
            relevanceScore: data['relevance_score'] as int? ?? 0);
      }).toList();
      return TeamNews(team: map['team'] as String, articles: articles);
    }).toList();
    final warnings = (json['warnings'] as List<dynamic>? ?? []).map((item) {
      final data = item as Map<String, dynamic>;
      return SourceWarning(
          source: data['source'] as String, message: data['message'] as String);
    }).toList();
    return NewsSearchResponseModel(SearchResult(
        requestId: json['request_id'] as String,
        generatedAt: DateTime.parse(json['generated_at'] as String),
        teams: teams,
        warnings: warnings,
        totalResults: json['total_results'] as int? ?? 0));
  }
}
