import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/local_settings_repository.dart';

part 'notifications_controller.g.dart';

@riverpod
class NotificationsController extends _$NotificationsController {
  @override
  Future<bool> build() async {
    final repository = ref.watch(settingsRepositoryProvider);
    return repository.getNotificationsEnabled();
  }

  Future<void> toggleNotifications(bool enabled) async {
    // Optimistic update
    state = AsyncData(enabled);
    
    // Persist
    final repository = ref.read(settingsRepositoryProvider);
    await repository.setNotificationsEnabled(enabled);
  }
}
