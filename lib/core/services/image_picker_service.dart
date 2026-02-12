import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker;

  ImagePickerService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  /// Picks an image from the gallery.
  /// Returns the File of the picked image or null if canceled.
  Future<File?> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024, // Resize for performance
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image == null) return null;

      return File(image.path);
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
  }
}
