import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Text(
            l10n.contactTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ContactItem(
                  icon: Icons.location_on,
                  title: l10n.addressTitle,
                  content: l10n.addressContent,
                ),
              ),
              Expanded(
                child: _ContactItem(
                  icon: Icons.phone,
                  title: l10n.phoneTitle,
                  content: l10n.phoneContent,
                ),
              ),
              Expanded(
                child: _ContactItem(
                  icon: Icons.access_time,
                  title: l10n.hoursTitle,
                  content: l10n.hoursContent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implementar ação de contato (WhatsApp ou Email)
            },
            icon: const Icon(Icons.message),
            label: Text(l10n.whatsappButton),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  AppColors.success, // Use success color for WhatsApp
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.secondary.withValues(alpha: 0.1),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
            size: 30,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
