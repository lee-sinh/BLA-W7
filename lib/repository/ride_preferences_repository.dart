import '../model/ride/ride_pref.dart';

abstract class RidePreferencesRepository {
  RidePreference? get currentPreference => null;

  Future<List<RidePreference>> getPastPreferences();

  Future<void> addPreference(RidePreference preference);

  void setCurrentPreference(RidePreference pref) {}
}
