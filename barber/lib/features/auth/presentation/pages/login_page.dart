import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barber/l10n/app_localizations.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _onClientLoginPressed(BuildContext context) {
    context.read<AuthBloc>().add(
      const AuthLoginRequested(email: 'cliente@email.com', password: '123'),
    );
  }

  void _onBarberLoginPressed(BuildContext context) {
    context.read<AuthBloc>().add(
      const AuthLoginRequested(email: 'barbeiro@email.com', password: '123'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colorScheme.error,
              ),
            );
          } else if (state is AuthSuccess) {
            if (state.user.userType == 'client') {
              Navigator.pushReplacementNamed(context, '/client-home');
            } else if (state.user.userType == 'barber') {
              Navigator.pushReplacementNamed(context, '/barber-home');
            } else {
              // Fallback
              Navigator.pushReplacementNamed(context, '/client-home');
            }
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.content_cut,
                  size: 80,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.welcomeTitle,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.loginPrompt,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 48),
                _LoginOptionButton(
                  icon: Icons.person,
                  label: l10n.imClient,
                  color: colorScheme.primary,
                  onPressed: () => _onClientLoginPressed(context),
                ),
                const SizedBox(height: 16),
                _LoginOptionButton(
                  icon: Icons.work,
                  label: l10n.imBarber,
                  color: colorScheme.secondary,
                  onPressed: () => _onBarberLoginPressed(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LoginOptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _LoginOptionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        icon: Icon(icon, size: 28),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
