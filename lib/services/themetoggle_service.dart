import 'package:stacked/stacked.dart';

class ThemetoggleService with ReactiveServiceMixin {
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemetoggleService() {
    listenToReactiveValues([_isDarkreactive]);
  }

  final ReactiveValue<bool> _isDarkreactive = ReactiveValue(false);

  void toggleTheme() {
    _isDarkreactive.value = !_isDarkreactive.value;
    _isDark = _isDarkreactive.value;
    notifyListeners();
  }
}
