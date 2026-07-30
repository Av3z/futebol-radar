import 'package:equatable/equatable.dart';

class SocialPost extends Equatable {
  const SocialPost({
    required this.id,
    required this.team,
    required this.platform,
    required this.author,
    required this.text,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.engagementScore,
  });

  final String id;
  final String team;
  final String platform;
  final String author;
  final String text;
  final String url;
  final String? imageUrl;
  final DateTime? publishedAt;
  final int likes;
  final int comments;
  final int shares;
  final int engagementScore;

  @override
  List<Object?> get props => [
        id,
        team,
        platform,
        author,
        text,
        url,
        imageUrl,
        publishedAt,
        likes,
        comments,
        shares,
        engagementScore,
      ];
}
