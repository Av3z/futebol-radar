import 'package:equatable/equatable.dart';

class EngagementFilters extends Equatable {
  const EngagementFilters({
    required this.teams,
    required this.sources,
    required this.maxResultsPerTeam,
    required this.periodHours,
  });

  final List<String> teams;
  final List<String> sources;
  final int maxResultsPerTeam;
  final int periodHours;

  @override
  List<Object?> get props => [teams, sources, maxResultsPerTeam, periodHours];
}
