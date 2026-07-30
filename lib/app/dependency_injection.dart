import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../features/news_search/data/datasources/news_remote_datasource.dart';
import '../features/news_search/data/repositories/news_repository_impl.dart';
import '../features/news_search/domain/repositories/news_repository.dart';
import '../features/news_search/domain/usecases/get_sources_usecase.dart';
import '../features/news_search/domain/usecases/search_news_usecase.dart';
import '../features/news_search/presentation/bloc/news_search_bloc.dart';
import '../core/storage/posted_news_store.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  final baseUrl = const String.fromEnvironment('API_BASE_URL',
      defaultValue: 'http://localhost:8000');
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 180))));
  getIt.registerLazySingleton<NewsRemoteDatasource>(
      () => NewsRemoteDatasource(getIt<Dio>()));
  getIt.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(getIt<NewsRemoteDatasource>()));
  getIt.registerLazySingleton(() => SearchNewsUsecase(getIt<NewsRepository>()));
  getIt.registerLazySingleton(() => GetSourcesUsecase(getIt<NewsRepository>()));
  getIt.registerLazySingleton(PostedNewsStore.new);
  getIt.registerFactory(() => NewsSearchBloc(getIt<SearchNewsUsecase>(),
      getIt<GetSourcesUsecase>(), getIt<PostedNewsStore>()));
}
