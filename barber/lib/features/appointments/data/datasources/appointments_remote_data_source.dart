import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/appointment_model.dart';

abstract class AppointmentsRemoteDataSource {
  Future<List<AppointmentModel>> getClientAppointments();
  Future<List<AppointmentModel>> getBarberAppointments();
}

class AppointmentsRemoteDataSourceImpl implements AppointmentsRemoteDataSource {
  final ApiClient apiClient;

  AppointmentsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<AppointmentModel>> getClientAppointments() async {
    try {
      final response = await apiClient.dio.get('/appointments');
      return (response.data as List)
          .map((e) => AppointmentModel.fromJsonClient(e))
          .toList();
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/appointments'),
        error: e,
      );
    }
  }

  @override
  Future<List<AppointmentModel>> getBarberAppointments() async {
    try {
      final response = await apiClient.dio.get('/barber/appointments');
      return (response.data as List)
          .map((e) => AppointmentModel.fromJsonBarber(e))
          .toList();
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/barber/appointments'),
        error: e,
      );
    }
  }
}
