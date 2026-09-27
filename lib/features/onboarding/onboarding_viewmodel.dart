import 'package:flutter/foundation.dart';

import '../../core/settings/settings_viewmodel.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/user_models.dart';

class OnboardingViewModel extends ChangeNotifier {
  OnboardingViewModel(this._settings);

  final SettingsViewModel _settings;
  final List<OnboardingSlide> slides = MockData.slides;

  int _index = 0;
  int get index => _index;
  bool get isLast => _index == slides.length - 1;

  void onPageChanged(int value) {
    if (value == _index) return;
    _index = value;
    notifyListeners();
  }

  // بعد كده التطبيق هيفتح على اختيار النوع على طول
  void finish() => _settings.completeOnboarding();
}
