import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:barber/features/auth/domain/entities/user_entity.dart';
import 'package:barber/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:barber/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:barber/l10n/app_localizations.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUpAll(() {
    registerFallbackValue(AuthLogoutRequested());
    registerFallbackValue(AuthInitial());
  });

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  Widget createWidgetUnderTest({bool isBarber = false}) {
    return MaterialApp(
      locale: const Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: EditProfilePage(isBarber: isBarber),
      ),
    );
  }

  group('EditProfilePage', () {
    testWidgets('renders EditProfilePage with user data', (tester) async {
      final user = UserEntity(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        userType: 'client',
        token: 'mock_token',
        phone: '123456789',
      );

      when(() => mockAuthBloc.state).thenReturn(AuthSuccess(user));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Editar Perfil'), findsOneWidget);
      expect(find.text('Nome Completo'), findsOneWidget);
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('123456789'), findsOneWidget);
    });

    testWidgets('renders additional fields for barber', (tester) async {
      final user = UserEntity(
        id: '2',
        name: 'Barber User',
        email: 'barber@example.com',
        userType: 'barber',
        token: 'mock_token',
        specialties: ['Corte', 'Barba'],
        bio: 'Experiente',
      );

      when(() => mockAuthBloc.state).thenReturn(AuthSuccess(user));

      await tester.pumpWidget(createWidgetUnderTest(isBarber: true));
      await tester.pump();

      expect(find.text('Especialidades'), findsOneWidget);
      expect(find.text('Corte, Barba'), findsOneWidget);
      expect(find.text('Bio / Sobre Mim'), findsOneWidget);
      expect(find.text('Experiente'), findsOneWidget);
    });

    testWidgets('shows validation error when fields are empty', (tester) async {
      final user = UserEntity(
        id: '1',
        name: '',
        email: '',
        userType: 'client',
        token: 'mock_token',
        phone: '',
      );

      when(() => mockAuthBloc.state).thenReturn(AuthSuccess(user));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Tap save button
      await tester.tap(find.text('Salvar Alterações'));
      await tester.pumpAndSettle();

      // Should show validation errors
      // Since we used labels as error messages in the validator logic:
      expect(find.text('Nome Completo'), findsNWidgets(2)); // Label + Error
      expect(find.text('Telefone'), findsNWidgets(2)); // Label + Error
      expect(find.text('E-mail'), findsNWidgets(2)); // Label + Error
    });
  });
}
