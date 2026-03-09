import '../../../../core/types/typedefs.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/appointment_entity.dart';
import '../repositories/appointments_repository.dart';

class GetBarberAppointmentsUseCase
    implements UseCase<List<AppointmentEntity>, NoParams> {
  final AppointmentsRepository repository;

  GetBarberAppointmentsUseCase(this.repository);

  @override
  FutureEither<List<AppointmentEntity>> call(NoParams params) {
    return repository.getBarberAppointments();
  }
}
