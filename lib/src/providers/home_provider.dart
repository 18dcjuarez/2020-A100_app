import 'package:flutter/foundation.dart';

class HomeProvider with ChangeNotifier {
  int _currentSlide = 0;

  int get currentSlide => _currentSlide;

  set currentSlide(int v) {
    if (v == _currentSlide) return;
    _currentSlide = v;
    notifyListeners();
  }
}
