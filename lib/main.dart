import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/presentation/providers/theme_controller.dart';
import 'core/presentation/providers/font_size_controller.dart';
import 'screens/settings_screen.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ModernTemplateApp(),
    ),
  );
}

class ModernTemplateApp extends ConsumerWidget {
  const ModernTemplateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeControllerProvider);
    final fontSizeAsync = ref.watch(fontSizeControllerProvider);

    return switch ((themeAsync, fontSizeAsync)) {
      (AsyncData(value: final themeMode), AsyncData(value: final fontSize)) =>
        MaterialApp(
          title: 'Flutter Modern Template',
          theme: AppTheme.lightTheme(fontSize),
          darkTheme: AppTheme.darkTheme(fontSize),
          themeMode: themeMode,
          home: const MainNavigator(),
          debugShowCheckedModeBanner: true,
        ),
      (AsyncError(error: final err), _) ||
      (_, AsyncError(error: final err)) =>
        MaterialApp(
          home: Scaffold(
            body: Center(child: Text('Error: $err')),
          ),
        ),
      _ => const MaterialApp(
          home: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        ),
    };
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text('Profile (Under Construction)')),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
