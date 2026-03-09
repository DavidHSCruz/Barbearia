part of 'landing_bloc.dart';

sealed class LandingState extends Equatable {
  const LandingState();

  @override
  List<Object> get props => [];
}

final class LandingInitial extends LandingState {}

final class LandingLoading extends LandingState {}

final class LandingLoaded extends LandingState {
  final List<ServiceItem> services;

  const LandingLoaded(this.services);

  @override
  List<Object> get props => [services];
}

final class LandingFailure extends LandingState {
  final String message;

  const LandingFailure(this.message);

  @override
  List<Object> get props => [message];
}
