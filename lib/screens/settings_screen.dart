import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/presentation/providers/theme_controller.dart';
import '../core/presentation/providers/notifications_controller.dart';
import '../core/presentation/providers/language_controller.dart';
import '../core/presentation/providers/font_size_controller.dart';
import '../features/auth/presentation/providers/auth_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeControllerProvider);
    final notificationsAsync = ref.watch(notificationsControllerProvider);
    final languageAsync = ref.watch(languageControllerProvider);
    final fontSizeAsync = ref.watch(fontSizeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection(context, 'Preferences', [
            // Notifications Toggle
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              subtitle: const Text('Receive push notifications'),
              trailing: notificationsAsync.when(
                data: (enabled) => Switch(
                  value: enabled,
                  onChanged: (value) {
                    ref.read(notificationsControllerProvider.notifier)
                       .toggleNotifications(value);
                  },
                ),
                loading: () => const SizedBox(
                  width: 24, 
                  height: 24, 
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (_, __) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
             // Theme Mode
             ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Theme Mode'),
              subtitle: const Text('Choose app appearance'),
              trailing: themeModeAsync.when(
                data: (mode) => DropdownButton<ThemeMode>(
                  value: mode,
                  onChanged: (ThemeMode? newMode) {
                    if (newMode != null) {
                      ref
                          .read(themeControllerProvider.notifier)
                          .updateThemeMode(newMode);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('System'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Light'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Dark'),
                    ),
                  ],
                ),
                loading: () => const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (_, __) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection(context, 'Appearance', [
            // Font Size Slider
            ListTile(
              leading: const Icon(Icons.text_fields),
              title: const Text('Font Size'),
              subtitle: fontSizeAsync.when(
                data: (size) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Size: ${size.round()}'),
                    Slider(
                      value: size,
                      min: 10.0,
                      max: 24.0,
                      divisions: 14,
                      label: size.round().toString(),
                      onChanged: (value) {
                        ref.read(fontSizeControllerProvider.notifier)
                           .updateFontSize(value);
                      },
                    ),
                  ],
                ),
                loading: () => const Text('Loading...'),
                error: (_, __) => const Text('Error loading font size'),
              ),
            ),
            // Language Dropdown
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: const Text('Select your language'),
              trailing: languageAsync.when(
                data: (lang) => DropdownButton<String>(
                  value: lang,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      ref.read(languageControllerProvider.notifier)
                         .updateLanguage(newValue);
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: 'English', child: Text('English')),
                    DropdownMenuItem(value: 'Spanish', child: Text('Spanish')),
                    DropdownMenuItem(value: 'French', child: Text('French')),
                    DropdownMenuItem(value: 'German', child: Text('German')),
                  ],
                ),
                loading: () => const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (_, __) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection(context, 'Networking Test', [
             Consumer(
               builder: (context, ref, child) {
                 final authState = ref.watch(authControllerProvider);
                 
                 return ListTile(
                   leading: const Icon(Icons.cloud_sync),
                   title: const Text('Test Login (reqres.in)'),
                   subtitle: authState.when(
                     data: (_) => const Text('Idle (Ready to test)'),
                     loading: () => const Text('Logging in...'),
                     error: (e, _) => Text('Error: ${e.toString()}', style: const TextStyle(color: Colors.red)),
                   ),
                   trailing: ElevatedButton(
                     onPressed: authState.isLoading ? null : () {
                       ref.read(authControllerProvider.notifier)
                          .login('eve.holt@reqres.in', 'cityslicka');
                     },
                     child: const Text('POST'),
                   ),
                 );
               },
             ),
          ]),
          const SizedBox(height: 24),
          _buildSection(context, 'About', [
            const ListTile(
              leading: Icon(Icons.info),
              title: Text('Version'),
              trailing: Text('1.0.0'),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }
}
