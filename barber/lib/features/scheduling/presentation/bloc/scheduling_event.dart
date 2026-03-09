part of 'scheduling_bloc.dart';

sealed class SchedulingEvent extends Equatable {
  const SchedulingEvent();

  @override
  List<Object> get props => [];
}

class SchedulingLoadData extends SchedulingEvent {}
