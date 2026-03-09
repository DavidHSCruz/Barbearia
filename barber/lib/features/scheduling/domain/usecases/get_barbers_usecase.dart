import '../../../../core/types/typedefs.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/barber_entity.dart';
import '../repositories/scheduling_repository.dart';

class GetBarbersUseCase implements UseCase<List<BarberEntity>, NoParams> {
  final SchedulingRepository repository;

  GetBarbersUseCase(this.repository);

  @override
  FutureEither<List<BarberEntity>> call(NoParams params) {
    return repository.getBarbers();
  }
}
