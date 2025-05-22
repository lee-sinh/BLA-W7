import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/ride/ride_filter.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../providers/rides_preferences_provider.dart'; // <-- Provider import
import '../../../service/rides_service.dart';
import '../../../ui/theme/theme.dart';
import '../../../utils/animations_util.dart';

import 'widgets/ride_pref_bar.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allows the user to select a ride,
///  once ride preferences have been defined.
///  The screen also allows the user to re-define the ride preferences and apply filters.
///
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  RideFilter currentFilter = RideFilter();

  @override
  Widget build(BuildContext context) {
    final ridePrefProvider = context.watch<RidesPreferencesProvider>();
    final currentPreference = ridePrefProvider.currentPreference!;
    final matchingRides =
        RidesService.instance.getRidesFor(currentPreference, currentFilter);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            // Top search bar
            RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: () => Navigator.of(context).pop(),
              onPreferencePressed: () async {
                final newPref = await Navigator.of(context).push<RidePreference>(
                  AnimationUtils.createTopToBottomRoute(
                    RidePrefModal(initialPreference: currentPreference),
                  ),
                );

                if (newPref != null) {
                  ridePrefProvider.setCurrentPreferrence(newPref);
                }
              },
              onFilterPressed: () {
                // TODO: Implement filter functionality
              },
            ),

            // Matching rides list
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideTile(
                  ride: matchingRides[index],
                  onPressed: () {}, // Handle ride tap
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
