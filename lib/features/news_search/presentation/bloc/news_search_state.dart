import 'package:equatable/equatable.dart';

import '../../domain/entities/search_filters.dart';
import '../../domain/entities/team_news.dart';

sealed class NewsSearchState extends Equatable {
  const NewsSearchState();
}

final class NewsSearchInitial extends NewsSearchState {
  const NewsSearchInitial();
  @override
  List<Object?> get props => [];
}

final class NewsSearchLoading extends NewsSearchState {
  const NewsSearchLoading();
  @override
  List<Object?> get props => [];
}

final class NewsSearchSuccess extends NewsSearchState {
  const NewsSearchSuccess(this.result);
  final SearchResult result;
  @override
  List<Object?> get props => [result];
}

final class NewsSearchEmpty extends NewsSearchState {
  const NewsSearchEmpty();
  @override
  List<Object?> get props => [];
}

final class NewsSearchFailure extends NewsSearchState {
  const NewsSearchFailure(this.message, {this.filters});
  final String message;
  final SearchFilters? filters;
  @override
  List<Object?> get props => [message, filters];
}

final class SourcesLoaded extends NewsSearchState {
  const SourcesLoaded(this.sources);
  final List<String> sources;
  @override
  List<Object?> get props => [sources];
}
