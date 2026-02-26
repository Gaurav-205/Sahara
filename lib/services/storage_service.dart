import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'cloudinary_service.dart';

/// Storage Service - Now using Cloudinary instead of Firebase Storage
/// 
/// This service provides image upload/download functionality using Cloudinary.
/// Cloudinary offers 25 GB storage and 25 GB bandwidth per month for FREE.
/// 
/// Setup Instructions:
/// 1. Sign up at https://cloudinary.com/
/// 2. Get your Cloud Name and Upload Preset from the dashboard
/// 3. Update credentials in cloudinary_service.dart
class StorageService {
  final CloudinaryService _cloudinary = CloudinaryService();

  // Pick image from gallery
  Future<XFile?> pickImageFromGallery() async {
    return await _cloudinary.pickImageFromGallery();
  }

  // Pick image from camera
  Future<XFile?> pickImageFromCamera() async {
    return await _cloudinary.pickImageFromCamera();
  }

  // Upload profile picture
  Future<String?> uploadProfilePicture(File file, String userId) async {
    return await _cloudinary.uploadProfilePicture(file, userId);
  }

  // Upload pet picture
  Future<String?> uploadPetPicture(File file, String petId) async {
    return await _cloudinary.uploadPetPicture(file, petId);
  }

  // Upload chat image
  Future<String?> uploadChatImage(File file) async {
    return await _cloudinary.uploadChatImage(file);
  }

  // Delete image
  Future<bool> deleteImage(String imageUrl) async {
    return await _cloudinary.deleteImage(imageUrl);
  }
}
