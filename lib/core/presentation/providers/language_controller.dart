import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/local_settings_repository.dart';

part 'language_controller.g.dart';

@riverpod
class LanguageController extends _$LanguageController {
  @override
  Future<String> build() async {
    final repository = ref.watch(settingsRepositoryProvider);
    return repository.getLanguage();
  }

  Future<void> updateLanguage(String language) async {
    state = AsyncData(language);
    final repository = ref.read(settingsRepositoryProvider);
    await repository.setLanguage(language);
  }
}
