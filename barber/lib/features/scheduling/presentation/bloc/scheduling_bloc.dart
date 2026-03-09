import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/barber_entity.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/usecases/get_barbers_usecase.dart';
import '../../domain/usecases/get_services_usecase.dart';

part 'scheduling_event.dart';
part 'scheduling_state.dart';

class SchedulingBloc extends Bloc<SchedulingEvent, SchedulingState> {
  final GetServicesUseCase _getServicesUseCase;
  final GetBarbersUseCase _getBarbersUseCase;

  SchedulingBloc({
    required GetServicesUseCase getServicesUseCase,
    required GetBarbersUseCase getBarbersUseCase,
  })  : _getServicesUseCase = getServicesUseCase,
        _getBarbersUseCase = getBarbersUseCase,
        super(SchedulingInitial()) {
    on<SchedulingLoadData>(_onLoadData);
  }

  Future<void> _onLoadData(
    SchedulingLoadData event,
    Emitter<SchedulingState> emit,
  ) async {
    emit(SchedulingLoading());

    // Executa as duas requisições em paralelo
    final results = await Future.wait([
      _getServicesUseCase(NoParams()),
      _getBarbersUseCase(NoParams()),
    ]);

    final servicesResult = results[0] as dynamic; // fpdart Either
    final barbersResult = results[1] as dynamic; // fpdart Either

    List<ServiceEntity>? services;
    List<BarberEntity>? barbers;
    String? errorMessage;

    servicesResult.fold(
      (failure) => errorMessage = failure.message,
      (data) => services = data,
    );

    if (errorMessage != null) {
      emit(SchedulingFailure(errorMessage!));
      return;
    }

    barbersResult.fold(
      (failure) => errorMessage = failure.message,
      (data) => barbers = data,
    );

    if (errorMessage != null) {
      emit(SchedulingFailure(errorMessage!));
      return;
    }

    emit(SchedulingLoaded(
      services: services!,
      barbers: barbers!,
    ));
  }
}
