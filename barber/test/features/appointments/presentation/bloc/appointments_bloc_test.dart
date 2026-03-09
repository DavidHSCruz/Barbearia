import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:barber/core/errors/failures.dart';
import 'package:barber/core/usecases/usecase.dart';
import 'package:barber/features/appointments/domain/entities/appointment_entity.dart';
import 'package:barber/features/appointments/domain/usecases/get_client_appointments_usecase.dart';
import 'package:barber/features/appointments/domain/usecases/get_barber_appointments_usecase.dart';
import 'package:barber/features/appointments/presentation/bloc/appointments_bloc.dart';

class MockGetClientAppointmentsUseCase extends Mock
    implements GetClientAppointmentsUseCase {}

class MockGetBarberAppointmentsUseCase extends Mock
    implements GetBarberAppointmentsUseCase {}

void main() {
  late AppointmentsBloc appointmentsBloc;
  late MockGetClientAppointmentsUseCase mockGetClientAppointmentsUseCase;
  late MockGetBarberAppointmentsUseCase mockGetBarberAppointmentsUseCase;

  setUp(() {
    registerFallbackValue(NoParams());
    mockGetClientAppointmentsUseCase = MockGetClientAppointmentsUseCase();
    mockGetBarberAppointmentsUseCase = MockGetBarberAppointmentsUseCase();
    appointmentsBloc = AppointmentsBloc(
      getClientAppointmentsUseCase: mockGetClientAppointmentsUseCase,
      getBarberAppointmentsUseCase: mockGetBarberAppointmentsUseCase,
    );
  });

  tearDown(() {
    appointmentsBloc.close();
  });

  final tAppointments = [
    const AppointmentEntity(
      id: 1,
      serviceName: 'Service 1',
      barberName: 'Barber 1',
      date: null,
      status: 'confirmed',
      price: 50.0,
      clientName: 'Client 1',
    ),
  ];

  test('initial state should be AppointmentsInitial', () {
    expect(appointmentsBloc.state, AppointmentsInitial());
  });

  group('LoadClientAppointments', () {
    blocTest<AppointmentsBloc, AppointmentsState>(
      'emits [AppointmentsLoading, AppointmentsLoaded] when successful',
      build: () {
        when(
          () => mockGetClientAppointmentsUseCase(any()),
        ).thenAnswer((_) async => Right(tAppointments));
        return appointmentsBloc;
      },
      act: (bloc) => bloc.add(LoadClientAppointments()),
      expect: () => [
        AppointmentsLoading(),
        AppointmentsLoaded(appointments: tAppointments, isClient: true),
      ],
    );

    blocTest<AppointmentsBloc, AppointmentsState>(
      'emits [AppointmentsLoading, AppointmentsFailure] when fails',
      build: () {
        when(
          () => mockGetClientAppointmentsUseCase(any()),
        ).thenAnswer((_) async => Left(ServerFailure('Error')));
        return appointmentsBloc;
      },
      act: (bloc) => bloc.add(LoadClientAppointments()),
      expect: () => [AppointmentsLoading(), const AppointmentsFailure('Error')],
    );
  });

  group('LoadBarberAppointments', () {
    blocTest<AppointmentsBloc, AppointmentsState>(
      'emits [AppointmentsLoading, AppointmentsLoaded] when successful',
      build: () {
        when(
          () => mockGetBarberAppointmentsUseCase(any()),
        ).thenAnswer((_) async => Right(tAppointments));
        return appointmentsBloc;
      },
      act: (bloc) => bloc.add(LoadBarberAppointments()),
      expect: () => [
        AppointmentsLoading(),
        AppointmentsLoaded(appointments: tAppointments, isClient: false),
      ],
    );

    blocTest<AppointmentsBloc, AppointmentsState>(
      'emits [AppointmentsLoading, AppointmentsFailure] when fails',
      build: () {
        when(
          () => mockGetBarberAppointmentsUseCase(any()),
        ).thenAnswer((_) async => Left(ServerFailure('Error')));
        return appointmentsBloc;
      },
      act: (bloc) => bloc.add(LoadBarberAppointments()),
      expect: () => [AppointmentsLoading(), const AppointmentsFailure('Error')],
    );
  });
}
