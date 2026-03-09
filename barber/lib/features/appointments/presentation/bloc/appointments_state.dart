part of 'appointments_bloc.dart';

sealed class AppointmentsState extends Equatable {
  const AppointmentsState();

  @override
  List<Object> get props => [];
}

final class AppointmentsInitial extends AppointmentsState {}

final class AppointmentsLoading extends AppointmentsState {}

final class AppointmentsLoaded extends AppointmentsState {
  final List<AppointmentEntity> appointments;
  final bool isClient;

  const AppointmentsLoaded({
    required this.appointments,
    required this.isClient,
  });

  @override
  List<Object> get props => [appointments, isClient];
}

final class AppointmentsFailure extends AppointmentsState {
  final String message;

  const AppointmentsFailure(this.message);

  @override
  List<Object> get props => [message];
}
