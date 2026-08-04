import 'package:equatable/equatable.dart';

class SearchFilters extends Equatable {
  const SearchFilters(
      {required this.teams,
      required this.sources,
      required this.keywords,
      required this.excludedTerms,
      required this.maxResultsPerTeam,
      required this.periodHours});
  final List<String> teams;
  final List<String> sources;
  final List<String> keywords;
  final List<String> excludedTerms;
  final int maxResultsPerTeam;
  final int periodHours;

  @override
  List<Object?> get props =>
      [teams, sources, keywords, excludedTerms, maxResultsPerTeam, periodHours];
}
