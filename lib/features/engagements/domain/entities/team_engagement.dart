import 'package:equatable/equatable.dart';

import 'social_post.dart';

class TeamEngagement extends Equatable {
  const TeamEngagement({required this.team, required this.posts});

  final String team;
  final List<SocialPost> posts;

  @override
  List<Object?> get props => [team, posts];
}

class EngagementWarning extends Equatable {
  const EngagementWarning({required this.source, required this.message});

  final String source;
  final String message;

  @override
  List<Object?> get props => [source, message];
}

class EngagementResult extends Equatable {
  const EngagementResult({
    required this.requestId,
    required this.generatedAt,
    required this.totalResults,
    required this.teams,
    required this.warnings,
  });

  final String requestId;
  final DateTime generatedAt;
  final int totalResults;
  final List<TeamEngagement> teams;
  final List<EngagementWarning> warnings;

  @override
  List<Object?> get props =>
      [requestId, generatedAt, totalResults, teams, warnings];
}
