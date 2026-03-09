import '../../../../core/types/typedefs.dart';
import '../entities/barber_entity.dart';
import '../entities/service_entity.dart';

abstract class SchedulingRepository {
  FutureEither<List<ServiceEntity>> getServices();
  FutureEither<List<BarberEntity>> getBarbers();
}
