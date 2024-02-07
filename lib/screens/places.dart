import 'package:favourite_places_app/providers/user_places.dart';
import 'package:flutter/material.dart';
import 'package:favourite_places_app/screens/add_place.dart';
import 'package:favourite_places_app/widgets/places_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  void addPlace() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: PlacesList(
          places: userPlaces,
        ),
      ),
    );
  }
}
