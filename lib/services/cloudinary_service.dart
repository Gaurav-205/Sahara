import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class CloudinaryService {
  // TODO: Replace with your Cloudinary credentials
  // Get these from: https://console.cloudinary.com/
  static const String _cloudName = 'dmbxyvrcc';
  static const String _uploadPreset = 'sahara_uploads';
  
  late final CloudinaryPublic _cloudinary;
  final ImagePicker _picker = ImagePicker();

  CloudinaryService() {
    _cloudinary = CloudinaryPublic(_cloudName, _uploadPreset, cache: false);
  }

  // Pick image from gallery
  Future<XFile?> pickImageFromGallery() async {
    try {
      return await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  // Pick image from camera
  Future<XFile?> pickImageFromCamera() async {
    try {
      return await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
    } catch (e) {
      debugPrint('Error taking photo: $e');
      return null;
    }
  }

  // Upload image to Cloudinary
  Future<String?> uploadImage({
    required File file,
    required String folder,
    String? fileName,
  }) async {
    try {
      final name = fileName ?? path.basenameWithoutExtension(file.path);
      
      CloudinaryResponse response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          folder: folder,
          publicId: name,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      
      debugPrint('Image uploaded: ${response.secureUrl}');
      return response.secureUrl;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return null;
    }
  }

  // Upload profile picture
  Future<String?> uploadProfilePicture(File file, String userId) async {
    return await uploadImage(
      file: file,
      folder: 'sahara/profile_pictures',
      fileName: userId,
    );
  }

  // Upload pet picture
  Future<String?> uploadPetPicture(File file, String petId) async {
    return await uploadImage(
      file: file,
      folder: 'sahara/pet_pictures',
      fileName: petId,
    );
  }

  // Upload chat image
  Future<String?> uploadChatImage(File file) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return await uploadImage(
      file: file,
      folder: 'sahara/chat_images',
      fileName: 'chat_$timestamp',
    );
  }

  // Delete image from Cloudinary
  // Note: The cloudinary_public package doesn't support deletion.
  // To delete images, you need to use the Cloudinary Admin API from your backend.
  // For now, we'll just return true (images will remain in Cloudinary but won't be referenced)
  Future<bool> deleteImage(String imageUrl) async {
    try {
      debugPrint('Image deletion not supported in client. Image URL: $imageUrl');
      debugPrint('To delete images, use Cloudinary Admin API from your backend.');
      return true; // Return true to not break the app flow
    } catch (e) {
      debugPrint('Error in deleteImage: $e');
      return false;
    }
  }
}
