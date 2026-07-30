import 'package:dio/dio.dart';

import '../../../../core/error/app_failure.dart';
import '../../domain/entities/search_filters.dart';
import '../models/news_search_models.dart';

class NewsRemoteDatasource {
  NewsRemoteDatasource(this.dio);
  final Dio dio;

  Future<NewsSearchResponseModel> search(SearchFilters filters) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
          '/api/v1/news/search',
          data: NewsSearchRequestModel(filters).toJson());
      return NewsSearchResponseModel.fromJson(response.data!);
    } on DioException catch (error) {
      final data = error.response?.data;
      final message = data is Map<String, dynamic>
          ? ((data['error'] as Map<String, dynamic>?)?['message'] as String?)
          : null;
      throw AppFailure(
          message ?? 'Não foi possível consultar as notícias agora.');
    } catch (_) {
      throw const AppFailure('A resposta da API não pôde ser interpretada.');
    }
  }

  Future<List<String>> getSources() async {
    try {
      final response = await dio.get<Map<String, dynamic>>('/api/v1/sources');
      return (response.data?['sources'] as List<dynamic>? ?? []).cast<String>();
    } on DioException {
      throw const AppFailure(
          'Não foi possível carregar as fontes disponíveis.');
    }
  }
}
