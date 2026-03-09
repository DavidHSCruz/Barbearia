import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:barber/core/constants/app_colors.dart';
import 'package:barber/core/providers/settings_provider.dart';
import 'package:barber/l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = settings.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: Text(
              l10n.notifications,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              l10n.notifications, // Maybe change to "Enable notifications" key if needed, but reusing is fine for now
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          const Divider(),
          SwitchListTile(
            title: Text(
              l10n.darkMode,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              l10n.darkMode,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            value: isDarkMode,
            onChanged: (val) => settings.toggleTheme(val),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            title: Text(
              l10n.language,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              settings.locale.languageCode == 'pt'
                  ? 'Português (Brasil)'
                  : settings.locale.languageCode == 'en'
                  ? 'English'
                  : 'Español',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: () => _showLanguageDialog(context, settings),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              l10n.logout,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Português (Brasil)'),
              onTap: () {
                settings.setLocale(const Locale('pt', 'BR'));
                Navigator.pop(context);
              },
              trailing: settings.locale.languageCode == 'pt'
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
            ),
            ListTile(
              title: const Text('English'),
              onTap: () {
                settings.setLocale(const Locale('en', ''));
                Navigator.pop(context);
              },
              trailing: settings.locale.languageCode == 'en'
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
            ),
            ListTile(
              title: const Text('Español'),
              onTap: () {
                settings.setLocale(const Locale('es', ''));
                Navigator.pop(context);
              },
              trailing: settings.locale.languageCode == 'es'
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
