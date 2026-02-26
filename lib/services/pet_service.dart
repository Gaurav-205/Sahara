import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pet_model.dart';

// Set to true to use mock data
const bool useMockPets = true;

class PetService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mock pets data
  final List<PetModel> _mockPets = [
    PetModel(
      id: 'pet_1',
      ownerId: 'mock_user_123',
      name: 'Max',
      type: 'Dog',
      breed: 'Golden Retriever',
      age: 3,
      weight: 30.0,
      gender: 'Male',
      color: 'Golden',
      isNeutered: true,
      vaccinations: ['Rabies', 'Distemper', 'Parvovirus'],
      medicalNotes: 'Allergic to chicken',
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    ),
    PetModel(
      id: 'pet_2',
      ownerId: 'mock_user_123',
      name: 'Luna',
      type: 'Cat',
      breed: 'Persian',
      age: 2,
      weight: 4.5,
      gender: 'Female',
      color: 'White',
      isNeutered: true,
      vaccinations: ['Rabies', 'FVRCP'],
      createdAt: DateTime.now().subtract(const Duration(days: 200)),
    ),
  ];

  // Get user's pets
  Future<List<PetModel>> getUserPets(String userId) async {
    if (useMockPets) {
      await Future.delayed(const Duration(milliseconds: 500));
      return _mockPets.where((pet) => pet.ownerId == userId).toList();
    }

    try {
      final snapshot = await _firestore
          .collection('pets')
          .where('ownerId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => PetModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Add pet
  Future<String> addPet(PetModel pet) async {
    if (useMockPets) {
      await Future.delayed(const Duration(milliseconds: 500));
      final newPet = pet.copyWith(
        id: 'pet_${DateTime.now().millisecondsSinceEpoch}',
      );
      _mockPets.add(newPet);
      return newPet.id;
    }

    final doc = await _firestore.collection('pets').add(pet.toMap());
    return doc.id;
  }

  // Update pet
  Future<void> updatePet(PetModel pet) async {
    if (useMockPets) {
      await Future.delayed(const Duration(milliseconds: 500));
      final index = _mockPets.indexWhere((p) => p.id == pet.id);
      if (index != -1) {
        _mockPets[index] = pet.copyWith(updatedAt: DateTime.now());
      }
      return;
    }

    await _firestore.collection('pets').doc(pet.id).update(pet.toMap());
  }

  // Delete pet
  Future<void> deletePet(String petId) async {
    if (useMockPets) {
      await Future.delayed(const Duration(milliseconds: 500));
      _mockPets.removeWhere((pet) => pet.id == petId);
      return;
    }

    await _firestore.collection('pets').doc(petId).delete();
  }

  // Get pet by ID
  Future<PetModel?> getPetById(String petId) async {
    if (useMockPets) {
      await Future.delayed(const Duration(milliseconds: 300));
      try {
        return _mockPets.firstWhere((pet) => pet.id == petId);
      } catch (e) {
        return null;
      }
    }

    try {
      final doc = await _firestore.collection('pets').doc(petId).get();
      if (doc.exists) {
        return PetModel.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

