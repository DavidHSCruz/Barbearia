import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/types/typedefs.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/repositories/appointments_repository.dart';
import '../datasources/appointments_remote_data_source.dart';

class AppointmentsRepositoryImpl implements AppointmentsRepository {
  final AppointmentsRemoteDataSource remoteDataSource;

  AppointmentsRepositoryImpl(this.remoteDataSource);

  @override
  FutureEither<List<AppointmentEntity>> getClientAppointments() async {
    try {
      final appointments = await remoteDataSource.getClientAppointments();
      return Right(appointments);
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;
        if (data is Map && data.containsKey('message')) {
          return Left(ServerFailure(data['message']));
        }
      }
      return const Left(ServerFailure('Falha ao buscar agendamentos do cliente'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  FutureEither<List<AppointmentEntity>> getBarberAppointments() async {
    try {
      final appointments = await remoteDataSource.getBarberAppointments();
      return Right(appointments);
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;
        if (data is Map && data.containsKey('message')) {
          return Left(ServerFailure(data['message']));
        }
      }
      return const Left(ServerFailure('Falha ao buscar agendamentos do barbeiro'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
