import '../../../../core/types/typedefs.dart';
import '../entities/barber_entity.dart';
import '../entities/service_entity.dart';

abstract class SchedulingRepository {
  ResultFuture<List<ServiceEntity>> getServices();
  ResultFuture<List<BarberEntity>> getBarbers();
}
