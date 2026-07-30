import 'package:equatable/equatable.dart';

import '../../domain/entities/search_filters.dart';

sealed class NewsSearchEvent extends Equatable {
  const NewsSearchEvent();
}

final class NewsSearchRequested extends NewsSearchEvent {
  const NewsSearchRequested(this.filters);
  final SearchFilters filters;

  @override
  List<Object?> get props => [filters];
}

final class NewsSearchCleared extends NewsSearchEvent {
  const NewsSearchCleared();
  @override
  List<Object?> get props => [];
}

final class NewsSearchRetried extends NewsSearchEvent {
  const NewsSearchRetried(this.filters);
  final SearchFilters filters;
  @override
  List<Object?> get props => [filters];
}

final class SourcesRequested extends NewsSearchEvent {
  const SourcesRequested();
  @override
  List<Object?> get props => [];
}

final class NewsPostStatusChanged extends NewsSearchEvent {
  const NewsPostStatusChanged(this.url);
  final String url;

  @override
  List<Object?> get props => [url];
}
