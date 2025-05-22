import 'package:flutter/material.dart';
import '../../../model/ride/ride_pref.dart';
import '../repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  List<RidePreference> _pastPreferences = [];
  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    // Fetch once from repository
    _pastPreferences = repository.getPastPreferences();
    _currentPreference = repository.currentPreference;
  }

  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreferrence(RidePreference pref) {
    _currentPreference = pref;
    _addPreference(pref);
    repository.setCurrentPreference(pref);
    notifyListeners();
  }

  void _addPreference(RidePreference preference) {
    // Avoid duplicates (optional logic)
    if (!_pastPreferences.contains(preference)) {
      _pastPreferences.add(preference);
    }
  }

  List<RidePreference> get preferencesHistory =>
      _pastPreferences.reversed.toList();
}
