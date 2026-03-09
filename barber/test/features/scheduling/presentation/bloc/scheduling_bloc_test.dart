import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:barber/core/errors/failures.dart';
import 'package:barber/core/usecases/usecase.dart';
import 'package:barber/features/scheduling/domain/entities/barber_entity.dart';
import 'package:barber/features/scheduling/domain/entities/service_entity.dart';
import 'package:barber/features/scheduling/domain/usecases/get_barbers_usecase.dart';
import 'package:barber/features/scheduling/domain/usecases/get_services_usecase.dart';
import 'package:barber/features/scheduling/presentation/bloc/scheduling_bloc.dart';

class MockGetServicesUseCase extends Mock implements GetServicesUseCase {}

class MockGetBarbersUseCase extends Mock implements GetBarbersUseCase {}

void main() {
  late SchedulingBloc schedulingBloc;
  late MockGetServicesUseCase mockGetServicesUseCase;
  late MockGetBarbersUseCase mockGetBarbersUseCase;

  setUp(() {
    registerFallbackValue(NoParams());
    mockGetServicesUseCase = MockGetServicesUseCase();
    mockGetBarbersUseCase = MockGetBarbersUseCase();
    schedulingBloc = SchedulingBloc(
      getServicesUseCase: mockGetServicesUseCase,
      getBarbersUseCase: mockGetBarbersUseCase,
    );
  });

  tearDown(() {
    schedulingBloc.close();
  });

  final tServices = [
    const ServiceEntity(
      id: 1,
      name: 'Service 1',
      price: 50.0,
      duration: 30,
      description: 'Description 1',
    ),
  ];

  final tBarbers = [
    const BarberEntity(id: 1, name: 'Barber 1', specialties: ['Corte']),
  ];

  test('initial state should be SchedulingInitial', () {
    expect(schedulingBloc.state, SchedulingInitial());
  });

  blocTest<SchedulingBloc, SchedulingState>(
    'emits [SchedulingLoading, SchedulingLoaded] when data loads successfully',
    build: () {
      when(
        () => mockGetServicesUseCase(any()),
      ).thenAnswer((_) async => Right(tServices));
      when(
        () => mockGetBarbersUseCase(any()),
      ).thenAnswer((_) async => Right(tBarbers));
      return schedulingBloc;
    },
    act: (bloc) => bloc.add(SchedulingLoadData()),
    expect: () => [
      SchedulingLoading(),
      SchedulingLoaded(services: tServices, barbers: tBarbers),
    ],
  );

  blocTest<SchedulingBloc, SchedulingState>(
    'emits [SchedulingLoading, SchedulingFailure] when services fail',
    build: () {
      when(
        () => mockGetServicesUseCase(any()),
      ).thenAnswer((_) async => Left(ServerFailure('Service Error')));
      when(
        () => mockGetBarbersUseCase(any()),
      ).thenAnswer((_) async => Right(tBarbers));
      return schedulingBloc;
    },
    act: (bloc) => bloc.add(SchedulingLoadData()),
    expect: () => [
      SchedulingLoading(),
      const SchedulingFailure('Service Error'),
    ],
  );

  blocTest<SchedulingBloc, SchedulingState>(
    'emits [SchedulingLoading, SchedulingFailure] when barbers fail',
    build: () {
      when(
        () => mockGetServicesUseCase(any()),
      ).thenAnswer((_) async => Right(tServices));
      when(
        () => mockGetBarbersUseCase(any()),
      ).thenAnswer((_) async => Left(ServerFailure('Barber Error')));
      return schedulingBloc;
    },
    act: (bloc) => bloc.add(SchedulingLoadData()),
    expect: () => [
      SchedulingLoading(),
      const SchedulingFailure('Barber Error'),
    ],
  );
}
