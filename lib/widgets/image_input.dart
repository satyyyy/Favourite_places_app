import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagepicker = ImagePicker();
    final pickedImage =
        await imagepicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = GestureDetector(
      onTap: _takePicture,
      child: TextButton.icon(
        onPressed: _takePicture,
        icon: const Icon(Icons.camera),
        label: const Text('Take Picture'),
      ),
    );

    if (_selectedImage != null) {
      content = Image.file(_selectedImage!, fit: BoxFit.cover);
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      child: content,
    );
  }
}
