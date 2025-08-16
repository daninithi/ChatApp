import 'package:chat_app/core/others/base_viewmodel.dart';



class BottomNavigationViewModel extends BaseViewmodel {
  int _currentIndex = 1;

  int get currentIndex => _currentIndex;

  setIndex(int value) {
    if (_currentIndex != value) {
      _currentIndex = value;
      notifyListeners();
    }
  }
}