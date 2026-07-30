import 'package:equatable/equatable.dart';

class NewsArticle extends Equatable {
  const NewsArticle(
      {required this.id,
      required this.title,
      required this.summary,
      required this.team,
      required this.source,
      required this.url,
      this.imageUrl,
      this.publishedAt,
      required this.publishedAtVerified,
      required this.matchedKeywords,
      required this.relevanceScore,
      this.isPosted = false});
  final String id;
  final String title;
  final String summary;
  final String team;
  final String source;
  final String url;
  final String? imageUrl;
  final DateTime? publishedAt;
  final bool publishedAtVerified;
  final List<String> matchedKeywords;
  final int relevanceScore;
  final bool isPosted;

  NewsArticle copyWith({bool? isPosted}) => NewsArticle(
      id: id,
      title: title,
      summary: summary,
      team: team,
      source: source,
      url: url,
      imageUrl: imageUrl,
      publishedAt: publishedAt,
      publishedAtVerified: publishedAtVerified,
      matchedKeywords: matchedKeywords,
      relevanceScore: relevanceScore,
      isPosted: isPosted ?? this.isPosted);

  @override
  List<Object?> get props => [
        id,
        title,
        summary,
        team,
        source,
        url,
        imageUrl,
        publishedAt,
        publishedAtVerified,
        matchedKeywords,
        relevanceScore,
        isPosted
      ];
}
