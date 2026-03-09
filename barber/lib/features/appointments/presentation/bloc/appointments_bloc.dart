import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/usecases/get_barber_appointments_usecase.dart';
import '../../domain/usecases/get_client_appointments_usecase.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final GetClientAppointmentsUseCase _getClientAppointmentsUseCase;
  final GetBarberAppointmentsUseCase _getBarberAppointmentsUseCase;

  AppointmentsBloc({
    required GetClientAppointmentsUseCase getClientAppointmentsUseCase,
    required GetBarberAppointmentsUseCase getBarberAppointmentsUseCase,
  })  : _getClientAppointmentsUseCase = getClientAppointmentsUseCase,
        _getBarberAppointmentsUseCase = getBarberAppointmentsUseCase,
        super(AppointmentsInitial()) {
    on<LoadClientAppointments>(_onLoadClientAppointments);
    on<LoadBarberAppointments>(_onLoadBarberAppointments);
  }

  Future<void> _onLoadClientAppointments(
    LoadClientAppointments event,
    Emitter<AppointmentsState> emit,
  ) async {
    emit(AppointmentsLoading());
    final result = await _getClientAppointmentsUseCase(NoParams());
    result.fold(
      (failure) => emit(AppointmentsFailure(failure.message)),
      (appointments) => emit(AppointmentsLoaded(
        appointments: appointments,
        isClient: true,
      )),
    );
  }

  Future<void> _onLoadBarberAppointments(
    LoadBarberAppointments event,
    Emitter<AppointmentsState> emit,
  ) async {
    emit(AppointmentsLoading());
    final result = await _getBarberAppointmentsUseCase(NoParams());
    result.fold(
      (failure) => emit(AppointmentsFailure(failure.message)),
      (appointments) => emit(AppointmentsLoaded(
        appointments: appointments,
        isClient: false,
      )),
    );
  }
}
