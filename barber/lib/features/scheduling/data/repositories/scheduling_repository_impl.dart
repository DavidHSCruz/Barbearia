import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/types/typedefs.dart';
import '../../domain/entities/barber_entity.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/repositories/scheduling_repository.dart';
import '../datasources/scheduling_remote_data_source.dart';

class SchedulingRepositoryImpl implements SchedulingRepository {
  final SchedulingRemoteDataSource remoteDataSource;

  SchedulingRepositoryImpl(this.remoteDataSource);

  @override
  FutureEither<List<ServiceEntity>> getServices() async {
    try {
      final services = await remoteDataSource.getServices();
      return Right(services);
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;
        if (data is Map && data.containsKey('message')) {
          return Left(ServerFailure(data['message']));
        }
      }
      return const Left(ServerFailure('Falha ao buscar serviços'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  FutureEither<List<BarberEntity>> getBarbers() async {
    try {
      final barbers = await remoteDataSource.getBarbers();
      return Right(barbers);
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;
        if (data is Map && data.containsKey('message')) {
          return Left(ServerFailure(data['message']));
        }
      }
      return const Left(ServerFailure('Falha ao buscar barbeiros'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
