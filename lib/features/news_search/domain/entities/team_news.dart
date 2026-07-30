import 'package:equatable/equatable.dart';

import 'news_article.dart';

class TeamNews extends Equatable {
  const TeamNews({required this.team, required this.articles});
  final String team;
  final List<NewsArticle> articles;

  TeamNews copyWith({List<NewsArticle>? articles}) =>
      TeamNews(team: team, articles: articles ?? this.articles);

  @override
  List<Object?> get props => [team, articles];
}

class SourceWarning extends Equatable {
  const SourceWarning({required this.source, required this.message});
  final String source;
  final String message;

  @override
  List<Object?> get props => [source, message];
}

class SearchResult extends Equatable {
  const SearchResult(
      {required this.requestId,
      required this.generatedAt,
      required this.teams,
      required this.warnings,
      required this.totalResults});
  final String requestId;
  final DateTime generatedAt;
  final List<TeamNews> teams;
  final List<SourceWarning> warnings;
  final int totalResults;

  SearchResult copyWith({List<TeamNews>? teams}) => SearchResult(
      requestId: requestId,
      generatedAt: generatedAt,
      teams: teams ?? this.teams,
      warnings: warnings,
      totalResults: totalResults);

  SearchResult withPostedUrls(Set<String> urls) => copyWith(
      teams: teams
          .map((team) => team.copyWith(
              articles: team.articles
                  .map((article) =>
                      article.copyWith(isPosted: urls.contains(article.url)))
                  .toList()))
          .toList());

  @override
  List<Object?> get props =>
      [requestId, generatedAt, teams, warnings, totalResults];
}
