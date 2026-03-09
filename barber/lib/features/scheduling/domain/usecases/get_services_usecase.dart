import '../../../../core/types/typedefs.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/service_entity.dart';
import '../repositories/scheduling_repository.dart';

class GetServicesUseCase implements UseCase<List<ServiceEntity>, NoParams> {
  final SchedulingRepository repository;

  GetServicesUseCase(this.repository);

  @override
  FutureEither<List<ServiceEntity>> call(NoParams params) {
    return repository.getServices();
  }
}
