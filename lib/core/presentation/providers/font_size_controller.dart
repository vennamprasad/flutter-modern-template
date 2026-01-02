import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/local_settings_repository.dart';

part 'font_size_controller.g.dart';

@riverpod
class FontSizeController extends _$FontSizeController {
  @override
  Future<double> build() async {
    final repository = ref.watch(settingsRepositoryProvider);
    return repository.getFontSize();
  }

  Future<void> updateFontSize(double size) async {
    state = AsyncData(size);
    final repository = ref.read(settingsRepositoryProvider);
    await repository.setFontSize(size);
  }
}
