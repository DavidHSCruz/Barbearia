import 'dart:async';
import 'dart:io';
import 'package:barber/l10n/app_localizations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:barber/features/landing/presentation/bloc/landing_bloc.dart';
import 'package:barber/features/landing/presentation/pages/landing_page.dart';
import 'package:barber/features/landing/domain/entities/landing_content.dart';

class MockLandingBloc extends MockBloc<LandingEvent, LandingState>
    implements LandingBloc {}

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _TestHttpClient();
  }
}

class _TestHttpClient extends Mock implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    return _TestHttpClientRequest();
  }
}

class _TestHttpClientRequest extends Mock implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async {
    return _TestHttpClientResponse();
  }
}

class _TestHttpClientResponse extends Mock implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => kTransparentImage.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream.value(kTransparentImage).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

final kTransparentImage = <int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
];

void main() {
  late MockLandingBloc mockLandingBloc;

  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
    registerFallbackValue(LandingLoadServices());
    registerFallbackValue(LandingInitial());
  });

  setUp(() {
    mockLandingBloc = MockLandingBloc();
    final getIt = GetIt.instance;
    if (getIt.isRegistered<LandingBloc>()) {
      getIt.unregister<LandingBloc>();
    }
    getIt.registerFactory<LandingBloc>(() => mockLandingBloc);
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      locale: const Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LandingPage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/login') {
          return MaterialPageRoute(builder: (_) => Container());
        }
        return null;
      },
    );
  }

  testWidgets('renders LandingPage and shows loading indicator when loading', (
    tester,
  ) async {
    when(() => mockLandingBloc.state).thenReturn(LandingLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders LandingPage and shows content when loaded', (
    tester,
  ) async {
    final services = [
      const ServiceItem(
        title: 'Corte',
        description: 'Corte de cabelo',
        iconPath: '',
      ),
    ];
    when(() => mockLandingBloc.state).thenReturn(LandingLoaded(services));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Corte'), findsOneWidget);
  });

  testWidgets('renders LandingPage and shows error message when failure', (
    tester,
  ) async {
    when(
      () => mockLandingBloc.state,
    ).thenReturn(const LandingFailure('Erro ao carregar'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Erro ao carregar'), findsOneWidget);
    expect(find.text('Tentar novamente'), findsOneWidget);
  });
}
