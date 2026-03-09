import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/landing_content.dart';
import '../../../../features/scheduling/domain/usecases/get_services_usecase.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  final GetServicesUseCase _getServicesUseCase;

  LandingBloc({required GetServicesUseCase getServicesUseCase})
      : _getServicesUseCase = getServicesUseCase,
        super(LandingInitial()) {
    on<LandingLoadServices>(_onLoadServices);
  }

  Future<void> _onLoadServices(
    LandingLoadServices event,
    Emitter<LandingState> emit,
  ) async {
    emit(LandingLoading());
    final result = await _getServicesUseCase(NoParams());

    result.fold(
      (failure) => emit(LandingFailure(failure.message)),
      (services) {
        final serviceItems = services.map((service) {
          return ServiceItem(
            title: service.name,
            description: service.description,
            iconPath: '', // Ícone será resolvido no widget
          );
        }).toList();
        emit(LandingLoaded(serviceItems));
      },
    );
  }
}
