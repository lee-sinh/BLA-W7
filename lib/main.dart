import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repository/mock/mock_locations_repository.dart';
import 'repository/mock/mock_rides_repository.dart';
import 'repository/mock/mock_ride_preferences_repository.dart';

import 'service/locations_service.dart';
import 'service/rides_service.dart';
import 'ui/screens/ride_pref/ride_pref_screen.dart';
import 'ui/theme/theme.dart';

import 'providers/rides_preferences_provider.dart';

void main() {
  // Initialize services that are still used
  LocationsService.initialize(MockLocationsRepository());
  RidesService.initialize(MockRidesRepository());

  runApp(
    ChangeNotifierProvider(
      create: (_) => RidesPreferencesProvider(
        repository: MockRidePreferencesRepository(),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const Scaffold(
        body: RidePrefScreen(),
      ),
    );
  }
}
