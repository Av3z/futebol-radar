import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/storage/posted_news_store.dart';
import '../../domain/usecases/get_sources_usecase.dart';
import '../../domain/usecases/search_news_usecase.dart';
import 'news_search_event.dart';
import 'news_search_state.dart';

class NewsSearchBloc extends Bloc<NewsSearchEvent, NewsSearchState> {
  NewsSearchBloc(this.searchNews, this.getSources, this.postedNewsStore)
      : super(const NewsSearchInitial()) {
    on<NewsSearchRequested>(_search);
    on<NewsSearchRetried>(_retry);
    on<NewsSearchCleared>((_, emit) => emit(const NewsSearchInitial()));
    on<SourcesRequested>(_sources);
    on<NewsPostStatusChanged>(_postStatusChanged);
  }
  final SearchNewsUsecase searchNews;
  final GetSourcesUsecase getSources;
  final PostedNewsStore postedNewsStore;

  Future<void> _search(
      NewsSearchRequested event, Emitter<NewsSearchState> emit) async {
    emit(const NewsSearchLoading());
    try {
      final result = (await searchNews(event.filters))
          .withPostedUrls(await postedNewsStore.getPostedUrls());
      emit(result.totalResults == 0
          ? const NewsSearchEmpty()
          : NewsSearchSuccess(result));
    } on AppFailure catch (error) {
      emit(NewsSearchFailure(error.message, filters: event.filters));
    }
  }

  Future<void> _postStatusChanged(
      NewsPostStatusChanged event, Emitter<NewsSearchState> emit) async {
    final current = state;
    if (current is! NewsSearchSuccess) return;
    final isPosted = await postedNewsStore.toggle(event.url);
    final result = current.result.copyWith(
        teams: current.result.teams
            .map((team) => team.copyWith(
                articles: team.articles
                    .map((article) => article.url == event.url
                        ? article.copyWith(isPosted: isPosted)
                        : article)
                    .toList()))
            .toList());
    emit(NewsSearchSuccess(result));
  }

  Future<void> _retry(NewsSearchRetried event, Emitter<NewsSearchState> emit) =>
      _search(NewsSearchRequested(event.filters), emit);

  Future<void> _sources(
      SourcesRequested event, Emitter<NewsSearchState> emit) async {
    try {
      emit(SourcesLoaded(await getSources()));
    } on AppFailure catch (error) {
      emit(NewsSearchFailure(error.message));
    }
  }
}
