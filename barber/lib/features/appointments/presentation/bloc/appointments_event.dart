part of 'appointments_bloc.dart';

sealed class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();

  @override
  List<Object> get props => [];
}

class LoadClientAppointments extends AppointmentsEvent {}

class LoadBarberAppointments extends AppointmentsEvent {}
