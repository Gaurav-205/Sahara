import '../models/service_package_model.dart';

class PackageService {
  // Mock packages for different services
  static final Map<String, List<ServicePackageModel>> _servicePackages = {
    'Dog Walking': [
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
    ],
    'Pet Sitting': [
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
    ],
    'Grooming': [
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
    ],
    'Vet Visit': [
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
    ],
  };

  // Get packages for a specific service
  static List<ServicePackageModel> getPackagesForService(String serviceType) {
    return _servicePackages[serviceType] ?? [];
  }

  // Get all service types
  static List<String> getAllServiceTypes() {
    return _servicePackages.keys.toList();
  }

  // Get package by ID
  static ServicePackageModel? getPackageById(String packageId) {
    for (var packages in _servicePackages.values) {
      try {
        return packages.firstWhere((pkg) => pkg.id == packageId);
      } catch (e) {
        continue;
      }
    }
    return null;
  }
}

