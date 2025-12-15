import 'package:flutter/widgets.dart';
import 'package:iism_2025/constants/sport.dart';

class MatchesViewModel extends ChangeNotifier {
  bool _isLiveMatchesScreen;
  Sports? _selectedSport;

  MatchesViewModel() : _selectedSport = null, _isLiveMatchesScreen = true;

  bool get isLiveMatchScreen => _isLiveMatchesScreen;
  Sports? get selectedSport => _selectedSport;

  void changeScreen(bool toLiveMatches) {
    _isLiveMatchesScreen = toLiveMatches;
    notifyListeners();
  }

  void updateSelectedSport(Sports? sport) {
    _selectedSport = sport;
    notifyListeners();
  }
}
