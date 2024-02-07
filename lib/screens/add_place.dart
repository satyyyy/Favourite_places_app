import 'package:favourite_places_app/models/place.dart';
import 'package:favourite_places_app/providers/user_places.dart';
import 'package:favourite_places_app/widgets/image_input.dart';
import 'package:favourite_places_app/widgets/locaation_input.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titlecontroller = TextEditingController();
  PlaceLocation? _selectedLocation;
  File? _selectedImage;

  @override
  void dispose() {
    _titlecontroller.dispose();
    super.dispose();
  }

  void _savePlace() {
    final enteredText = _titlecontroller.text;

    if (enteredText.isEmpty || _selectedImage == null) {
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredText, _selectedImage!, _selectedLocation!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title Here'),
            controller: _titlecontroller,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 20),
          ImageInput(
            onPickImage: (image) {
              _selectedImage = image;
            },
          ),
          const SizedBox(height: 20),
          LocationInput(
            onSelectedLocation: (location) {
              _selectedLocation = location;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Submit'),
          ),
        ]),
      ),
    );
  }
}
