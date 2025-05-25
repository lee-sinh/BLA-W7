import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/providers/async_value.dart';
import '../../../model/ride/ride_pref.dart';
import '../repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  AsyncValue<List<RidePreference>> pastPreferences = AsyncValue.loading();
  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    fetchPastPreferences();
    _currentPreference = repository.currentPreference;
  }

  RidePreference? get currentPreference => _currentPreference;

  Future<void> setCurrentPreferrence(RidePreference pref) async {
    _currentPreference = pref;
    repository.setCurrentPreference(pref);
    await repository.addPreference(pref);
    await fetchPastPreferences();
  }

  Future<void> fetchPastPreferences() async {
    pastPreferences = AsyncValue.loading();
    notifyListeners();
    try {
      final prefs = await repository.getPastPreferences();
      pastPreferences = AsyncValue.success(prefs);
    } catch (e) {
      pastPreferences = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
