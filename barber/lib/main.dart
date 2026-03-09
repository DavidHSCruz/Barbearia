import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barber/core/di/injection_container.dart' as di;
import 'package:barber/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:barber/l10n/app_localizations.dart';
import 'package:barber/core/routes/app_routes.dart';
import 'package:barber/core/theme/app_theme.dart';
import 'package:barber/core/providers/settings_provider.dart';
import 'package:barber/core/network/api_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        Provider<ApiClient>(create: (_) => di.sl<ApiClient>()),
        BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
      ],
      child: const BarberApp(),
    ),
  );
}

class BarberApp extends StatelessWidget {
  const BarberApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      title: 'Barber App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.themeMode,
      locale: settings.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', ''),
        Locale('es', ''),
      ],
      initialRoute: AppRoutes.landing,
      routes: AppRoutes.routes,
    );
  }
}
