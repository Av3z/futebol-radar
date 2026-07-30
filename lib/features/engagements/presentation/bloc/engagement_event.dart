import 'package:equatable/equatable.dart';

import '../../domain/entities/engagement_filters.dart';

sealed class EngagementEvent extends Equatable {
  const EngagementEvent();
}

final class EngagementSearchRequested extends EngagementEvent {
  const EngagementSearchRequested(this.filters);

  final EngagementFilters filters;

  @override
  List<Object?> get props => [filters];
}

final class EngagementSearchRetried extends EngagementEvent {
  const EngagementSearchRetried(this.filters);

  final EngagementFilters filters;

  @override
  List<Object?> get props => [filters];
}

final class EngagementSearchCleared extends EngagementEvent {
  const EngagementSearchCleared();

  @override
  List<Object?> get props => [];
}
