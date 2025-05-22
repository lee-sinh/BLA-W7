import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/rides_preferences_provider.dart'; // <-- Import the provider
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import '../rides/rides_screen.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ridePrefProvider = context.watch<RidesPreferencesProvider>();
    final currentRidePreference = ridePrefProvider.currentPreference;
    final pastPreferences = ridePrefProvider.preferencesHistory;

    return Stack(
      children: [
        // 1 - Background  Image
        const BlaBackground(),

        // 2 - Foreground content
        Column(
          children: [
            const SizedBox(height: BlaSpacings.m),
            Text(
              "Your pick of rides at low price",
              style: BlaTextStyles.heading.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 100),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Ride preference form
                  RidePrefForm(
                    initialPreference: currentRidePreference,
                    onSubmit: (newPreference) async {
                      ridePrefProvider.setCurrentPreferrence(newPreference);
                      await Navigator.of(context).push(
                        AnimationUtils.createBottomToTopRoute(
                          const RidesScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: BlaSpacings.m),

                  // Past preferences list
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: pastPreferences.length,
                      itemBuilder: (ctx, index) => RidePrefHistoryTile(
                        ridePref: pastPreferences[index],
                        onPressed: () async {
                          ridePrefProvider.setCurrentPreferrence(
                            pastPreferences[index],
                          );
                          await Navigator.of(context).push(
                            AnimationUtils.createBottomToTopRoute(
                              const RidesScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BlaBackground extends StatelessWidget {
  const BlaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
