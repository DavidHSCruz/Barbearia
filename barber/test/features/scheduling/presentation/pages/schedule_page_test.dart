import 'package:barber/l10n/app_localizations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:barber/features/scheduling/domain/entities/barber_entity.dart';
import 'package:barber/features/scheduling/domain/entities/service_entity.dart';
import 'package:barber/features/scheduling/presentation/bloc/scheduling_bloc.dart';
import 'package:barber/features/scheduling/presentation/pages/schedule_page.dart';

class MockSchedulingBloc extends MockBloc<SchedulingEvent, SchedulingState>
    implements SchedulingBloc {}

void main() {
  late MockSchedulingBloc mockSchedulingBloc;

  setUpAll(() {
    registerFallbackValue(SchedulingLoadData());
    registerFallbackValue(SchedulingInitial());
  });

  setUp(() {
    mockSchedulingBloc = MockSchedulingBloc();
    final getIt = GetIt.instance;
    if (getIt.isRegistered<SchedulingBloc>()) {
      getIt.unregister<SchedulingBloc>();
    }
    getIt.registerFactory<SchedulingBloc>(() => mockSchedulingBloc);
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      locale: const Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SchedulePage(),
    );
  }

  testWidgets('renders SchedulePage and shows loading indicator when loading', (
    tester,
  ) async {
    when(() => mockSchedulingBloc.state).thenReturn(SchedulingLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders SchedulePage and shows error message when failure', (
    tester,
  ) async {
    when(
      () => mockSchedulingBloc.state,
    ).thenReturn(const SchedulingFailure('Erro ao carregar'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Erro ao carregar'), findsOneWidget);
    expect(find.text('Tentar novamente'), findsOneWidget);
  });

  testWidgets('renders SchedulePage and shows form when loaded', (
    tester,
  ) async {
    final services = [
      const ServiceEntity(
        id: 1,
        name: 'Service 1',
        description: 'Desc 1',
        price: 50.0,
        duration: 30,
      ),
    ];
    final barbers = [
      const BarberEntity(id: 1, name: 'Barber 1', specialties: ['Corte']),
    ];

    when(
      () => mockSchedulingBloc.state,
    ).thenReturn(SchedulingLoaded(services: services, barbers: barbers));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Agendar Serviço'), findsOneWidget);
    expect(find.text('Serviço'), findsOneWidget);
    // You might want to add more expectations here based on the form content
  });
}
