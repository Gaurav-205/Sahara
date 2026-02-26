import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/booking_model.dart';
import '../models/review_model.dart';

// Mock data is now integrated directly into this service
const bool useMockFirestore = true;

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mock data for caregivers
  final List<UserModel> _mockCaregivers = [
    UserModel(
      uid: 'caregiver_1',
      email: 'priya.sharma@example.com',
      name: 'Priya Sharma',
      userType: 'caregiver',
      rating: 4.9,
      completedBookings: 120,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      bio: 'Passionate pet lover with 5+ years of experience.',
      services: ['Dog Walking', 'Pet Sitting', 'Grooming', 'Training'],
      hourlyRate: 450.0,
      location: 'Koramangala, Bengaluru',
      yearsOfExperience: 5,
      isVerified: true,
      isAvailable: true,
    ),
    UserModel(
      uid: 'caregiver_2',
      email: 'rahul.verma@example.com',
      name: 'Rahul Verma',
      userType: 'caregiver',
      rating: 4.8,
      completedBookings: 95,
      createdAt: DateTime.now().subtract(const Duration(days: 300)),
      bio: 'Experienced dog walker and pet sitter.',
      services: ['Dog Walking', 'Pet Sitting', 'Pet Transportation'],
      hourlyRate: 350.0,
      location: 'Bandra West, Mumbai',
      yearsOfExperience: 4,
      isVerified: true,
      isAvailable: true,
    ),
    UserModel(
      uid: 'caregiver_3',
      email: 'anjali.patel@example.com',
      name: 'Anjali Patel',
      userType: 'caregiver',
      rating: 4.7,
      completedBookings: 78,
      createdAt: DateTime.now().subtract(const Duration(days: 250)),
      bio: 'Certified pet groomer and trainer.',
      services: ['Grooming', 'Training', 'Pet Sitting'],
      hourlyRate: 550.0,
      location: 'Whitefield, Bengaluru',
      yearsOfExperience: 3,
      isVerified: true,
      isAvailable: true,
    ),
    UserModel(
      uid: 'caregiver_4',
      email: 'vikram.singh@example.com',
      name: 'Vikram Singh',
      userType: 'caregiver',
      rating: 4.6,
      completedBookings: 65,
      createdAt: DateTime.now().subtract(const Duration(days: 200)),
      bio: 'Veterinary assistant with pet care expertise.',
      services: ['Vet Visit', 'Pet Sitting', 'Dog Walking'],
      hourlyRate: 400.0,
      location: 'Indiranagar, Bengaluru',
      yearsOfExperience: 4,
      isVerified: true,
      isAvailable: false,
    ),
    UserModel(
      uid: 'caregiver_5',
      email: 'meera.reddy@example.com',
      name: 'Meera Reddy',
      userType: 'caregiver',
      rating: 4.9,
      completedBookings: 142,
      createdAt: DateTime.now().subtract(const Duration(days: 400)),
      bio: 'Professional pet sitter and dog trainer.',
      services: ['Pet Sitting', 'Training', 'Dog Walking'],
      hourlyRate: 500.0,
      location: 'Hitech City, Hyderabad',
      yearsOfExperience: 6,
      isVerified: true,
      isAvailable: true,
    ),
    UserModel(
      uid: 'caregiver_6',
      email: 'arjun.kumar@example.com',
      name: 'Arjun Kumar',
      userType: 'caregiver',
      rating: 4.5,
      completedBookings: 52,
      createdAt: DateTime.now().subtract(const Duration(days: 180)),
      bio: 'Pet lover with experience in all breeds.',
      services: ['Dog Walking', 'Pet Transportation', 'Pet Sitting'],
      hourlyRate: 300.0,
      location: 'Powai, Mumbai',
      yearsOfExperience: 2,
      isVerified: false,
      isAvailable: true,
    ),
  ];

  // Mock reviews
  final Map<String, List<ReviewModel>> _mockReviews = {};


  // Get all caregivers
  Stream<List<UserModel>> getCaregivers() {
    if (useMockFirestore) {
      return Stream.value(_mockCaregivers);
    }
    
    return _firestore
        .collection('users')
        .where('userType', isEqualTo: 'caregiver')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Get top rated caregivers
  Future<List<UserModel>> getTopCaregivers({int limit = 10}) async {
    if (useMockFirestore) {
      await Future.delayed(const Duration(milliseconds: 500));
      final sorted = List<UserModel>.from(_mockCaregivers)
        ..sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
      return sorted.take(limit).toList();
    }
    
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('userType', isEqualTo: 'caregiver')
          .orderBy('rating', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Search caregivers by service
  Future<List<UserModel>> searchCaregiversByService(String service) async {
    if (useMockFirestore) {
      await Future.delayed(const Duration(milliseconds: 500));
      return _mockCaregivers.where((caregiver) {
        return caregiver.services?.any((s) => 
          s.toLowerCase().contains(service.toLowerCase())) ?? false;
      }).toList();
    }
    
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('userType', isEqualTo: 'caregiver')
          .where('services', arrayContains: service)
          .get();

      return snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Search caregivers by location
  Future<List<UserModel>> searchCaregiversByLocation(String location) async {
    if (useMockFirestore) {
      await Future.delayed(const Duration(milliseconds: 500));
      return _mockCaregivers.where((caregiver) {
        return caregiver.location?.toLowerCase().contains(location.toLowerCase()) ?? false;
      }).toList();
    }
    
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('userType', isEqualTo: 'caregiver')
          .get();

      return snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id))
          .where((user) => user.location?.toLowerCase().contains(location.toLowerCase()) ?? false)
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Get available caregivers
  Future<List<UserModel>> getAvailableCaregivers() async {
    if (useMockFirestore) {
      await Future.delayed(const Duration(milliseconds: 500));
      return _mockCaregivers.where((caregiver) => 
        caregiver.isAvailable == true).toList();
    }
    
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('userType', isEqualTo: 'caregiver')
          .where('isAvailable', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Create booking
  Future<String> createBooking(BookingModel booking) async {
    if (useMockFirestore) {
      await Future.delayed(const Duration(milliseconds: 500));
      return 'mock_booking_${DateTime.now().millisecondsSinceEpoch}';
    }
    
    final doc = await _firestore.collection('bookings').add(booking.toMap());
    return doc.id;
  }

  // Get user bookings
  Stream<List<BookingModel>> getUserBookings(String userId) {
    if (useMockFirestore) {
      return Stream.value([]);
    }
    
    return _firestore
        .collection('bookings')
        .where('ownerId', isEqualTo: userId)
        .orderBy('scheduledDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BookingModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Get caregiver bookings
  Stream<List<BookingModel>> getCaregiverBookings(String caregiverId) {
    if (useMockFirestore) {
      return Stream.value([]);
    }
    
    return _firestore
        .collection('bookings')
        .where('caregiverId', isEqualTo: caregiverId)
        .orderBy('scheduledDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BookingModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Update booking status
  Future<void> updateBookingStatus(String bookingId, String status) async {
    if (useMockFirestore) {
      await Future.delayed(const Duration(milliseconds: 500));
      return;
    }
    
    await _firestore.collection('bookings').doc(bookingId).update({
      'status': status,
    });
  }

  // Update user profile
  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    if (useMockFirestore) {
      await Future.delayed(const Duration(milliseconds: 500));
      return;
    }
    
    await _firestore.collection('users').doc(uid).update(data);
  }

  // Get caregiver reviews
  Future<List<ReviewModel>> getCaregiverReviews(String caregiverId) async {
    if (useMockFirestore) {
      await Future.delayed(const Duration(milliseconds: 300));
      return _mockReviews[caregiverId] ?? [];
    }
    
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('caregiverId', isEqualTo: caregiverId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ReviewModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Add review
  Future<void> addReview(ReviewModel review) async {
    if (useMockFirestore) {
      await Future.delayed(const Duration(milliseconds: 500));
      return;
    }
    
    await _firestore.collection('reviews').add(review.toMap());
  }
}

