import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/landing_bloc.dart';
import '../widgets/contact_section.dart';
import '../widgets/history_section.dart';
import '../widgets/landing_banner.dart';
import '../widgets/services_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LandingBloc>()..add(LandingLoadServices()),
      child: const _LandingView(),
    );
  }
}

class _LandingView extends StatelessWidget {
  const _LandingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: Text(AppLocalizations.of(context)!.login),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<LandingBloc, LandingState>(
        builder: (context, state) {
          if (state is LandingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LandingFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<LandingBloc>().add(LandingLoadServices()),
                    child: Text(AppLocalizations.of(context)!.retry),
                  ),
                ],
              ),
            );
          } else if (state is LandingLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const LandingBanner(),
                  ServicesSection(services: state.services),
                  const HistorySection(),
                  const ContactSection(),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
