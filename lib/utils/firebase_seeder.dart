import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/service_package_model.dart';

/// Firebase Data Seeder
/// Seeds initial data to Firebase Firestore following industry standards
/// 
/// Usage:
/// ```dart
/// final seeder = FirebaseSeeder();
/// await seeder.seedAll();
/// ```
class FirebaseSeeder {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Seed all data (caregivers, packages, etc.)
  Future<void> seedAll() async {
    debugPrint('🌱 Starting Firebase data seeding...');
    
    try {
      await seedCaregivers();
      await seedServicePackages();
      
      debugPrint('✅ Firebase seeding completed successfully!');
    } catch (e) {
      debugPrint('❌ Error seeding data: $e');
      rethrow;
    }
  }

  /// Seed caregiver profiles
  Future<void> seedCaregivers() async {
    debugPrint('📝 Seeding caregivers...');

    final caregivers = [
      UserModel(
        uid: 'caregiver_priya_sharma',
        email: 'priya.sharma@sahara.app',
        name: 'Priya Sharma',
        userType: 'caregiver',
        rating: 4.9,
        completedBookings: 120,
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        bio: 'Passionate pet lover with 5+ years of experience in pet care. Certified in pet first aid and CPR. I treat every pet like my own family member.',
        services: ['Dog Walking', 'Pet Sitting', 'Grooming', 'Training'],
        hourlyRate: 450.0,
        location: 'Koramangala, Bengaluru',
        yearsOfExperience: 5,
        isVerified: true,
        isAvailable: true,
        phone: '+91 98765 43210',
      ),
      UserModel(
        uid: 'caregiver_rahul_verma',
        email: 'rahul.verma@sahara.app',
        name: 'Rahul Verma',
        userType: 'caregiver',
        rating: 4.8,
        completedBookings: 95,
        createdAt: DateTime.now().subtract(const Duration(days: 300)),
        bio: 'Experienced dog walker and pet sitter. I love spending time outdoors with dogs and ensuring they get the exercise they need.',
        services: ['Dog Walking', 'Pet Sitting', 'Pet Transportation'],
        hourlyRate: 350.0,
        location: 'Bandra West, Mumbai',
        yearsOfExperience: 4,
        isVerified: true,
        isAvailable: true,
        phone: '+91 98765 43211',
      ),
      UserModel(
        uid: 'caregiver_anjali_patel',
        email: 'anjali.patel@sahara.app',
        name: 'Anjali Patel',
        userType: 'caregiver',
        rating: 4.7,
        completedBookings: 78,
        createdAt: DateTime.now().subtract(const Duration(days: 250)),
        bio: 'Certified pet groomer and trainer with expertise in positive reinforcement techniques. Specialized in breed-specific grooming.',
        services: ['Grooming', 'Training', 'Pet Sitting'],
        hourlyRate: 550.0,
        location: 'Whitefield, Bengaluru',
        yearsOfExperience: 3,
        isVerified: true,
        isAvailable: true,
        phone: '+91 98765 43212',
      ),
      UserModel(
        uid: 'caregiver_vikram_singh',
        email: 'vikram.singh@sahara.app',
        name: 'Vikram Singh',
        userType: 'caregiver',
        rating: 4.6,
        completedBookings: 65,
        createdAt: DateTime.now().subtract(const Duration(days: 200)),
        bio: 'Veterinary assistant with pet care expertise. I understand pet health needs and can administer medications as prescribed.',
        services: ['Vet Visit', 'Pet Sitting', 'Dog Walking'],
        hourlyRate: 400.0,
        location: 'Indiranagar, Bengaluru',
        yearsOfExperience: 4,
        isVerified: true,
        isAvailable: false,
        phone: '+91 98765 43213',
      ),
      UserModel(
        uid: 'caregiver_meera_reddy',
        email: 'meera.reddy@sahara.app',
        name: 'Meera Reddy',
        userType: 'caregiver',
        rating: 4.9,
        completedBookings: 142,
        createdAt: DateTime.now().subtract(const Duration(days: 400)),
        bio: 'Professional pet sitter and dog trainer. I specialize in behavioral training and overnight pet care services.',
        services: ['Pet Sitting', 'Training', 'Dog Walking'],
        hourlyRate: 500.0,
        location: 'Hitech City, Hyderabad',
        yearsOfExperience: 6,
        isVerified: true,
        isAvailable: true,
        phone: '+91 98765 43214',
      ),
      UserModel(
        uid: 'caregiver_arjun_kumar',
        email: 'arjun.kumar@sahara.app',
        name: 'Arjun Kumar',
        userType: 'caregiver',
        rating: 4.5,
        completedBookings: 52,
        createdAt: DateTime.now().subtract(const Duration(days: 180)),
        bio: 'Pet lover with experience in all breeds. I provide reliable and caring pet services with flexible scheduling.',
        services: ['Dog Walking', 'Pet Transportation', 'Pet Sitting'],
        hourlyRate: 300.0,
        location: 'Powai, Mumbai',
        yearsOfExperience: 2,
        isVerified: false,
        isAvailable: true,
        phone: '+91 98765 43215',
      ),
      UserModel(
        uid: 'caregiver_sneha_desai',
        email: 'sneha.desai@sahara.app',
        name: 'Sneha Desai',
        userType: 'caregiver',
        rating: 4.8,
        completedBookings: 88,
        createdAt: DateTime.now().subtract(const Duration(days: 320)),
        bio: 'Experienced with cats and small pets. I provide gentle, patient care for shy or anxious pets.',
        services: ['Pet Sitting', 'Grooming', 'Pet Transportation'],
        hourlyRate: 380.0,
        location: 'Andheri East, Mumbai',
        yearsOfExperience: 3,
        isVerified: true,
        isAvailable: true,
        phone: '+91 98765 43216',
      ),
      UserModel(
        uid: 'caregiver_karthik_nair',
        email: 'karthik.nair@sahara.app',
        name: 'Karthik Nair',
        userType: 'caregiver',
        rating: 4.7,
        completedBookings: 71,
        createdAt: DateTime.now().subtract(const Duration(days: 280)),
        bio: 'Dog training specialist with focus on obedience and agility training. Patient and results-oriented approach.',
        services: ['Training', 'Dog Walking', 'Pet Sitting'],
        hourlyRate: 480.0,
        location: 'Jayanagar, Bengaluru',
        yearsOfExperience: 4,
        isVerified: true,
        isAvailable: true,
        phone: '+91 98765 43217',
      ),
    ];

    // Batch write for better performance
    final batch = _firestore.batch();
    
    for (final caregiver in caregivers) {
      final docRef = _firestore.collection('users').doc(caregiver.uid);
      batch.set(docRef, caregiver.toMap());
    }

    await batch.commit();
    debugPrint('✅ Seeded ${caregivers.length} caregivers');
  }

  /// Seed service packages
  Future<void> seedServicePackages() async {
    debugPrint('📝 Seeding service packages...');

    final packages = <ServicePackageModel>[
      // Dog Walking Packages
      ServicePackageModel(
        id: 'dw_basic',
        serviceType: 'Dog Walking',
        packageName: 'Basic Walk',
        description: 'Perfect for a quick outdoor break',
        price: 200.0,
        duration: '30 minutes',
        features: [
          'Neighborhood walk',
          'Basic exercise',
          'Photo updates',
          'GPS tracking',
        ],
        isPopular: false,
      ),
      ServicePackageModel(
        id: 'dw_standard',
        serviceType: 'Dog Walking',
        packageName: 'Standard Walk',
        description: 'Ideal for daily exercise routine',
        price: 350.0,
        duration: '1 hour',
        features: [
          'Extended park walk',
          'Playtime included',
          'Photo & video updates',
          'GPS tracking',
          'Fresh water provided',
        ],
        isPopular: true,
      ),
      ServicePackageModel(
        id: 'dw_premium',
        serviceType: 'Dog Walking',
        packageName: 'Premium Adventure',
        description: 'Ultimate outdoor experience',
        price: 500.0,
        duration: '2 hours',
        features: [
          'Trail or beach walk',
          'Extended playtime',
          'Photo & video updates',
          'GPS tracking',
          'Fresh water & treats',
          'Post-walk grooming',
        ],
        isPopular: false,
        discount: '10% off first booking',
      ),

      // Pet Sitting Packages
      ServicePackageModel(
        id: 'ps_basic',
        serviceType: 'Pet Sitting',
        packageName: 'Basic Care',
        description: 'Essential pet care at your home',
        price: 400.0,
        duration: '4 hours',
        features: [
          'Feeding & water',
          'Playtime',
          'Litter box cleaning',
          'Photo updates',
        ],
        isPopular: false,
      ),
      ServicePackageModel(
        id: 'ps_standard',
        serviceType: 'Pet Sitting',
        packageName: 'Full Day Care',
        description: 'Complete care throughout the day',
        price: 700.0,
        duration: '8 hours',
        features: [
          'Multiple feedings',
          'Extended playtime',
          'Litter box cleaning',
          'Photo & video updates',
          'Medication administration',
          'Home security check',
        ],
        isPopular: true,
      ),
      ServicePackageModel(
        id: 'ps_premium',
        serviceType: 'Pet Sitting',
        packageName: 'Overnight Care',
        description: '24/7 care and companionship',
        price: 1200.0,
        duration: '24 hours',
        features: [
          'All meals provided',
          'Overnight stay',
          'Unlimited playtime',
          'Regular photo updates',
          'Medication administration',
          'Home security',
          'Plant watering',
        ],
        isPopular: false,
      ),

      // Grooming Packages
      ServicePackageModel(
        id: 'gr_basic',
        serviceType: 'Grooming',
        packageName: 'Basic Grooming',
        description: 'Essential grooming services',
        price: 500.0,
        duration: '1 hour',
        features: [
          'Bath & dry',
          'Brush out',
          'Nail trim',
          'Ear cleaning',
        ],
        isPopular: false,
      ),
      ServicePackageModel(
        id: 'gr_standard',
        serviceType: 'Grooming',
        packageName: 'Full Grooming',
        description: 'Complete grooming package',
        price: 900.0,
        duration: '2 hours',
        features: [
          'Bath & blow dry',
          'Haircut/styling',
          'Nail trim & filing',
          'Ear cleaning',
          'Teeth brushing',
          'Cologne spray',
        ],
        isPopular: true,
      ),
      ServicePackageModel(
        id: 'gr_premium',
        serviceType: 'Grooming',
        packageName: 'Spa Package',
        description: 'Luxury spa treatment',
        price: 1500.0,
        duration: '3 hours',
        features: [
          'Premium bath & blow dry',
          'Breed-specific styling',
          'Nail trim & polish',
          'Ear & teeth cleaning',
          'Paw pad treatment',
          'Massage therapy',
          'Premium cologne',
          'Bow or bandana',
        ],
        isPopular: false,
        discount: '15% off first visit',
      ),

      // Vet Visit Packages
      ServicePackageModel(
        id: 'vv_basic',
        serviceType: 'Vet Visit',
        packageName: 'Transportation Only',
        description: 'Safe transport to vet appointment',
        price: 300.0,
        duration: '1 hour',
        features: [
          'Pick up & drop off',
          'Safe transport',
          'Wait during appointment',
          'Photo updates',
        ],
        isPopular: false,
      ),
      ServicePackageModel(
        id: 'vv_standard',
        serviceType: 'Vet Visit',
        packageName: 'Vet Companion',
        description: 'Full support during vet visit',
        price: 500.0,
        duration: '2 hours',
        features: [
          'Pick up & drop off',
          'Appointment attendance',
          'Note taking',
          'Medication pickup',
          'Photo & text updates',
        ],
        isPopular: true,
      ),
      ServicePackageModel(
        id: 'vv_premium',
        serviceType: 'Vet Visit',
        packageName: 'Complete Care',
        description: 'Full day vet visit support',
        price: 800.0,
        duration: '4 hours',
        features: [
          'Pick up & drop off',
          'Appointment attendance',
          'Detailed notes',
          'Medication pickup',
          'Follow-up care',
          'Post-visit comfort',
          'Detailed report',
        ],
        isPopular: false,
      ),
    ];

    // Batch write for better performance
    final batch = _firestore.batch();
    
    for (final package in packages) {
      final docRef = _firestore.collection('service_packages').doc(package.id);
      batch.set(docRef, package.toMap());
    }

    await batch.commit();
    debugPrint('✅ Seeded ${packages.length} service packages');
  }

  /// Clear all seeded data (use with caution!)
  Future<void> clearAllData() async {
    debugPrint('🗑️  Clearing all seeded data...');
    
    try {
      // Delete caregivers
      final caregiverSnapshot = await _firestore
          .collection('users')
          .where('userType', isEqualTo: 'caregiver')
          .get();
      
      final batch1 = _firestore.batch();
      for (final doc in caregiverSnapshot.docs) {
        batch1.delete(doc.reference);
      }
      await batch1.commit();
      debugPrint('✅ Cleared caregivers');

      // Delete service packages
      final packageSnapshot = await _firestore
          .collection('service_packages')
          .get();
      
      final batch2 = _firestore.batch();
      for (final doc in packageSnapshot.docs) {
        batch2.delete(doc.reference);
      }
      await batch2.commit();
      debugPrint('✅ Cleared service packages');

      debugPrint('✅ All data cleared successfully!');
    } catch (e) {
      debugPrint('❌ Error clearing data: $e');
      rethrow;
    }
  }
}
