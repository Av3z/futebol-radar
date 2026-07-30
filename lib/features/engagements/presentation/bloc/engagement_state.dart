import 'package:equatable/equatable.dart';

import '../../domain/entities/engagement_filters.dart';
import '../../domain/entities/team_engagement.dart';

sealed class EngagementState extends Equatable {
  const EngagementState();
}

final class EngagementInitial extends EngagementState {
  const EngagementInitial();

  @override
  List<Object?> get props => [];
}

final class EngagementLoading extends EngagementState {
  const EngagementLoading();

  @override
  List<Object?> get props => [];
}

final class EngagementSuccess extends EngagementState {
  const EngagementSuccess(this.result);

  final EngagementResult result;

  @override
  List<Object?> get props => [result];
}

final class EngagementEmpty extends EngagementState {
  const EngagementEmpty(this.result);

  final EngagementResult result;

  @override
  List<Object?> get props => [result];
}

final class EngagementFailure extends EngagementState {
  const EngagementFailure(this.message, {this.filters});

  final String message;
  final EngagementFilters? filters;

  @override
  List<Object?> get props => [message, filters];
}
