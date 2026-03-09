import '../../../../core/types/typedefs.dart';
import '../entities/appointment_entity.dart';

abstract class AppointmentsRepository {
  FutureEither<List<AppointmentEntity>> getClientAppointments();
  FutureEither<List<AppointmentEntity>> getBarberAppointments();
}
