import '../../../../core/types/typedefs.dart';
import '../entities/appointment_entity.dart';

abstract class AppointmentsRepository {
  ResultFuture<List<AppointmentEntity>> getClientAppointments();
  ResultFuture<List<AppointmentEntity>> getBarberAppointments();
}
