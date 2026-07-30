import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/app_failure.dart';
import '../../domain/usecases/search_engagement_usecase.dart';
import 'engagement_event.dart';
import 'engagement_state.dart';

class EngagementBloc extends Bloc<EngagementEvent, EngagementState> {
  EngagementBloc(this.searchEngagement) : super(const EngagementInitial()) {
    on<EngagementSearchRequested>(_search);
    on<EngagementSearchRetried>(_retry);
    on<EngagementSearchCleared>((_, emit) => emit(const EngagementInitial()));
  }

  final SearchEngagementUsecase searchEngagement;

  Future<void> _search(
      EngagementSearchRequested event, Emitter<EngagementState> emit) async {
    emit(const EngagementLoading());
    try {
      final result = await searchEngagement(event.filters);
      emit(result.totalResults == 0
          ? EngagementEmpty(result)
          : EngagementSuccess(result));
    } on AppFailure catch (error) {
      emit(EngagementFailure(error.message, filters: event.filters));
    }
  }

  Future<void> _retry(
          EngagementSearchRetried event, Emitter<EngagementState> emit) =>
      _search(EngagementSearchRequested(event.filters), emit);
}
