import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:barber/core/providers/settings_provider.dart';
import 'package:barber/features/settings/presentation/pages/settings_page.dart';
import 'package:barber/l10n/app_localizations.dart';

class MockSettingsProvider extends Mock implements SettingsProvider {}

void main() {
  late MockSettingsProvider mockSettingsProvider;

  setUp(() {
    mockSettingsProvider = MockSettingsProvider();
    when(() => mockSettingsProvider.themeMode).thenReturn(ThemeMode.light);
    when(
      () => mockSettingsProvider.locale,
    ).thenReturn(const Locale('pt', 'BR'));
  });

  Widget createWidgetUnderTest() {
    return ChangeNotifierProvider<SettingsProvider>.value(
      value: mockSettingsProvider,
      child: MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SettingsPage(),
      ),
    );
  }

  testWidgets('renders SettingsPage', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Configurações'), findsOneWidget);
    expect(find.text('Notificações'), findsNWidgets(2)); // Title and Subtitle
    expect(find.text('Modo Escuro'), findsNWidgets(2)); // Title and Subtitle
    expect(find.text('Idioma'), findsOneWidget);
    expect(find.text('Sair da Conta'), findsOneWidget);
  });

  testWidgets('toggles theme when switch is tapped', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Find the switch for Dark Mode. It's the second switch (after Notifications).
    final switches = find.byType(Switch);
    expect(switches, findsNWidgets(2));

    // Tap the second switch (Dark Mode)
    await tester.tap(switches.last);
    await tester.pump();

    verify(() => mockSettingsProvider.toggleTheme(true)).called(1);
  });

  testWidgets('opens language dialog when language tile is tapped', (
    tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Idioma'));
    await tester.pumpAndSettle();

    // Dialog should be open
    expect(find.text('Português (Brasil)'), findsWidgets);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Español'), findsOneWidget);

    // Tap English
    await tester.tap(find.text('English'));
    verify(
      () => mockSettingsProvider.setLocale(const Locale('en', '')),
    ).called(1);
  });
}
