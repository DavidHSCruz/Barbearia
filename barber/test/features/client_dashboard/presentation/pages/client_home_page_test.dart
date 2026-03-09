import 'package:barber/l10n/app_localizations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:barber/features/appointments/domain/entities/appointment_entity.dart';
import 'package:barber/features/appointments/presentation/bloc/appointments_bloc.dart';
import 'package:barber/features/client_dashboard/presentation/pages/client_home_page.dart';

class MockAppointmentsBloc
    extends MockBloc<AppointmentsEvent, AppointmentsState>
    implements AppointmentsBloc {}

void main() {
  late MockAppointmentsBloc mockAppointmentsBloc;

  setUpAll(() {
    registerFallbackValue(LoadClientAppointments());
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
      home: const ClientHomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/client-schedule' ||
            settings.name == '/edit-profile-client' ||
            settings.name == '/settings' ||
            settings.name == '/') {
          return MaterialPageRoute(builder: (_) => Container());
        }
        return null;
      },
    );
  }

  testWidgets(
    'renders ClientHomePage and shows loading indicator when loading',
    (tester) async {
      when(() => mockAppointmentsBloc.state).thenReturn(AppointmentsLoading());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets('renders ClientHomePage and shows error message when failure', (
    tester,
  ) async {
    when(
      () => mockAppointmentsBloc.state,
    ).thenReturn(const AppointmentsFailure('Erro ao carregar'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Erro ao carregar'), findsOneWidget);
  });

  testWidgets('renders ClientHomePage and shows appointments when loaded', (
    tester,
  ) async {
    final appointments = [
      AppointmentEntity(
        id: 1,
        serviceName: 'Corte',
        barberName: 'Barbeiro 1',
        date: DateTime(2023, 10, 10, 10, 0),
        status: 'confirmed',
        price: 50.0,
        clientName: 'Cliente 1',
      ),
    ];

    when(() => mockAppointmentsBloc.state).thenReturn(
      AppointmentsLoaded(appointments: appointments, isClient: true),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Meus Agendamentos'), findsOneWidget);
    expect(find.text('Corte'), findsOneWidget);
    expect(find.textContaining('Barbeiro 1'), findsOneWidget);
  });

  testWidgets(
    'renders ClientHomePage and shows empty message when no appointments',
    (tester) async {
      when(
        () => mockAppointmentsBloc.state,
      ).thenReturn(const AppointmentsLoaded(appointments: [], isClient: true));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Nenhum agendamento'), findsOneWidget);
    },
  );
}
