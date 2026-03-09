part of 'scheduling_bloc.dart';

sealed class SchedulingState extends Equatable {
  const SchedulingState();

  @override
  List<Object> get props => [];
}

final class SchedulingInitial extends SchedulingState {}

final class SchedulingLoading extends SchedulingState {}

final class SchedulingLoaded extends SchedulingState {
  final List<ServiceEntity> services;
  final List<BarberEntity> barbers;

  const SchedulingLoaded({
    required this.services,
    required this.barbers,
  });

  @override
  List<Object> get props => [services, barbers];
}

final class SchedulingFailure extends SchedulingState {
  final String message;

  const SchedulingFailure(this.message);

  @override
  List<Object> get props => [message];
}
