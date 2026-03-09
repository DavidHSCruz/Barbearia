import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/landing/presentation/pages/landing_page.dart';
import '../../features/client_dashboard/presentation/pages/client_home_page.dart';
import '../../features/scheduling/presentation/pages/schedule_page.dart';
import '../../features/barber_dashboard/presentation/pages/barber_home_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';

sealed class AppRoutes {
  static const String landing = '/';
  static const String login = '/login';
  static const String clientHome = '/client-home';
  static const String schedule = '/schedule';
  static const String clientSchedule = '/client-schedule';
  static const String barberHome = '/barber-home';
  static const String settings = '/settings';
  static const String editProfileClient = '/edit-profile-client';
  static const String editProfileBarber = '/edit-profile-barber';

  static Map<String, WidgetBuilder> get routes => {
        landing: (context) => const LandingPage(),
        login: (context) => const LoginPage(),
        clientHome: (context) => const ClientHomePage(),
        schedule: (context) => const SchedulePage(isGuest: true),
        clientSchedule: (context) => const SchedulePage(isGuest: false),
        barberHome: (context) => const BarberHomePage(),
        settings: (context) => const SettingsPage(),
        editProfileClient: (context) => const EditProfilePage(isBarber: false),
        editProfileBarber: (context) => const EditProfilePage(isBarber: true),
      };
}
