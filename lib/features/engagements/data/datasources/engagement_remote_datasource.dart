import 'package:dio/dio.dart';

import '../../../../core/error/app_failure.dart';
import '../../domain/entities/engagement_filters.dart';
import '../models/engagement_models.dart';

class EngagementRemoteDatasource {
  const EngagementRemoteDatasource(this.dio);

  final Dio dio;

  Future<EngagementSearchResponseModel> search(
      EngagementFilters filters) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/api/v1/engagements/search',
        data: EngagementSearchRequestModel(filters).toJson(),
      );
      return EngagementSearchResponseModel.fromJson(response.data!);
    } on DioException catch (error) {
      final data = error.response?.data;
      final message = data is Map<String, dynamic>
          ? ((data['error'] as Map<String, dynamic>?)?['message'] as String?)
          : null;
      throw AppFailure(
          message ?? 'Não foi possível consultar os engajamentos.');
    } catch (_) {
      throw const AppFailure(
          'A resposta dos engajamentos não pôde ser interpretada.');
    }
  }
}
