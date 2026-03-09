import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/barber_model.dart';
import '../models/service_model.dart';

abstract class SchedulingRemoteDataSource {
  Future<List<ServiceModel>> getServices();
  Future<List<BarberModel>> getBarbers();
}

class SchedulingRemoteDataSourceImpl implements SchedulingRemoteDataSource {
  final ApiClient apiClient;

  SchedulingRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      final response = await apiClient.dio.get('/services');
      return (response.data as List)
          .map((e) => ServiceModel.fromJson(e))
          .toList();
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/services'),
        error: e,
      );
    }
  }

  @override
  Future<List<BarberModel>> getBarbers() async {
    try {
      final response = await apiClient.dio.get('/barbers');
      return (response.data as List)
          .map((e) => BarberModel.fromJson(e))
          .toList();
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/barbers'),
        error: e,
      );
    }
  }
}
