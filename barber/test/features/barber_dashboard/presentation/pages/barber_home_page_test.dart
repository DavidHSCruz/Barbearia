import 'package:barber/l10n/app_localizations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:barber/features/appointments/domain/entities/appointment_entity.dart';
import 'package:barber/features/appointments/presentation/bloc/appointments_bloc.dart';
import 'package:barber/features/barber_dashboard/presentation/pages/barber_home_page.dart';

class MockAppointmentsBloc
    extends MockBloc<AppointmentsEvent, AppointmentsState>
    implements AppointmentsBloc {}

void main() {
  late MockAppointmentsBloc mockAppointmentsBloc;

  setUpAll(() {
    registerFallbackValue(LoadBarberAppointments());
    registerFallbackValue(AppointmentsInitial());
  });

  setUp(() {
    mockAppointmentsBloc = MockAppointmentsBloc();
    final getIt = GetIt.instance;
    if (getIt.isRegistered<AppointmentsBloc>()) {
      getIt.unregister<AppointmentsBloc>();
    }
    getIt.registerFactory<AppointmentsBloc>(() => mockAppointmentsBloc);
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      locale: const Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const BarberHomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/settings' || settings.name == '/') {
          return MaterialPageRoute(builder: (_) => Container());
        }
        return null;
      },
    );
  }

  testWidgets(
    'renders BarberHomePage and shows loading indicator when loading',
    (tester) async {
      when(() => mockAppointmentsBloc.state).thenReturn(AppointmentsLoading());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets('renders BarberHomePage and shows error message when failure', (
    tester,
  ) async {
    when(
      () => mockAppointmentsBloc.state,
    ).thenReturn(const AppointmentsFailure('Erro ao carregar'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Erro ao carregar'), findsOneWidget);
  });

  testWidgets('renders BarberHomePage and shows appointments when loaded', (
    tester,
  ) async {
    final appointments = [
      AppointmentEntity(
        id: 1,
        serviceName: 'Corte',
        clientName: 'Cliente 1',
        date: DateTime(2023, 10, 10, 10, 0),
        status: 'confirmed',
        price: 50.0,
      ),
    ];

    when(() => mockAppointmentsBloc.state).thenReturn(
      AppointmentsLoaded(appointments: appointments, isClient: false),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Meus Agendamentos'), findsWidgets); // Title and BottomNav
    expect(find.text('Corte'), findsOneWidget);
    expect(find.textContaining('Cliente 1'), findsOneWidget);
    expect(find.text('Confirmado'), findsOneWidget);
  });

  testWidgets('renders BarberHomePage and navigates to Profile tab', (
    tester,
  ) async {
    when(
      () => mockAppointmentsBloc.state,
    ).thenReturn(const AppointmentsLoaded(appointments: [], isClient: false));

    await tester.pumpWidget(createWidgetUnderTest());

    // Tap on Profile tab
    await tester.tap(find.text('Meu Perfil'));
    await tester.pumpAndSettle();

    expect(find.text('Barbeiro Profissional'), findsOneWidget);
    expect(find.text('barbeiro@email.com'), findsOneWidget);
  });
}
