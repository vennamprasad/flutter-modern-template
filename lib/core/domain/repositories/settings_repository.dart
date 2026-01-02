import 'package:flutter/material.dart';

/// [SettingsRepository]
///
/// The contract for general app settings.
abstract class SettingsRepository {
  /// Check if notifications are enabled.
  Future<bool> getNotificationsEnabled();

  /// Set the notification preference.
  Future<void> setNotificationsEnabled(bool enabled);

  /// Get the selected language.
  Future<String> getLanguage();

  /// Set the selected language.
  Future<void> setLanguage(String language);

  /// Get the font size.
  Future<double> getFontSize();

  /// Set the font size.
  Future<void> setFontSize(double size);

  /// Check if the user is logged in.
  Future<bool> isLoggedIn();
  /// Set the logged-in status.
  Future<void> setLoggedIn(bool loggedIn);

  Future<ThemeMode> getThemeMode();

  /// Persist the selected theme mode.
  Future<void> setThemeMode(ThemeMode mode);
}
