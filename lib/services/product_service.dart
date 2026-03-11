import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get all products
  Stream<List<ProductModel>> getProducts() {
    return _firestore
        .collection('products')
        .where('isAvailable', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  /// Get products by category
  Stream<List<ProductModel>> getProductsByCategory(String category) {
    if (category == 'All') {
      return getProducts();
    }

    return _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .where('isAvailable', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  /// Get product by ID
  Future<ProductModel?> getProductById(String productId) async {
    try {
      final doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        return ProductModel.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting product: $e');
      return null;
    }
  }

  /// Search products
  Stream<List<ProductModel>> searchProducts(String query) {
    return _firestore
        .collection('products')
        .where('isAvailable', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      final products = snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
          .toList();

      // Filter by name (case-insensitive)
      return products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  /// Seed sample products (for development)
  Future<void> seedProducts() async {
    final products = [
      {
        'name': 'Premium Dog Food 5kg',
        'description':
            'High-quality dog food with real chicken, vegetables, and essential nutrients. Perfect for adult dogs of all breeds.',
        'price': 999.0,
        'category': 'Food',
        'images': ['https://via.placeholder.com/400x400?text=Dog+Food'],
        'rating': 4.5,
        'reviewCount': 120,
        'stock': 50,
        'isAvailable': true,
        'discount': '20% OFF',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Interactive Cat Toy Bundle',
        'description':
            'Set of 5 interactive toys including feather wand, balls, and mice. Keeps your cat entertained for hours.',
        'price': 499.0,
        'category': 'Toys',
        'images': ['https://via.placeholder.com/400x400?text=Cat+Toys'],
        'rating': 4.8,
        'reviewCount': 85,
        'stock': 30,
        'isAvailable': true,
        'discount': '15% OFF',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Adjustable Pet Collar',
        'description':
            'Durable nylon collar with quick-release buckle. Adjustable size fits most pets. Available in multiple colors.',
        'price': 299.0,
        'category': 'Accessories',
        'images': ['https://via.placeholder.com/400x400?text=Pet+Collar'],
        'rating': 4.3,
        'reviewCount': 65,
        'stock': 100,
        'isAvailable': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Stainless Steel Food Bowl Set',
        'description':
            'Set of 2 stainless steel bowls with non-slip rubber base. Easy to clean and dishwasher safe.',
        'price': 399.0,
        'category': 'Accessories',
        'images': ['https://via.placeholder.com/400x400?text=Food+Bowls'],
        'rating': 4.6,
        'reviewCount': 95,
        'stock': 75,
        'isAvailable': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Natural Pet Shampoo',
        'description':
            'Gentle, pH-balanced shampoo with natural ingredients. Suitable for sensitive skin. Pleasant lavender scent.',
        'price': 249.0,
        'category': 'Grooming',
        'images': ['https://via.placeholder.com/400x400?text=Pet+Shampoo'],
        'rating': 4.7,
        'reviewCount': 110,
        'stock': 60,
        'isAvailable': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Dental Chew Toys Pack',
        'description':
            'Pack of 3 dental chew toys that help clean teeth and massage gums. Made from safe, non-toxic rubber.',
        'price': 349.0,
        'category': 'Toys',
        'images': ['https://via.placeholder.com/400x400?text=Chew+Toys'],
        'rating': 4.4,
        'reviewCount': 78,
        'stock': 45,
        'isAvailable': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Orthopedic Pet Bed Large',
        'description':
            'Memory foam pet bed with removable, washable cover. Provides excellent support for joints and muscles.',
        'price': 1499.0,
        'category': 'Accessories',
        'images': ['https://via.placeholder.com/400x400?text=Pet+Bed'],
        'rating': 4.9,
        'reviewCount': 145,
        'stock': 25,
        'isAvailable': true,
        'discount': '25% OFF',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Healthy Treats Variety Pack',
        'description':
            'Assorted pack of healthy treats including chicken, beef, and fish flavors. No artificial preservatives.',
        'price': 199.0,
        'category': 'Food',
        'images': ['https://via.placeholder.com/400x400?text=Pet+Treats'],
        'rating': 4.5,
        'reviewCount': 92,
        'stock': 80,
        'isAvailable': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Professional Grooming Kit',
        'description':
            'Complete grooming kit with brush, comb, nail clipper, and scissors. Everything you need for home grooming.',
        'price': 899.0,
        'category': 'Grooming',
        'images': ['https://via.placeholder.com/400x400?text=Grooming+Kit'],
        'rating': 4.6,
        'reviewCount': 68,
        'stock': 35,
        'isAvailable': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Multivitamin Supplements',
        'description':
            'Daily multivitamin supplements for overall health. Supports immune system, coat, and joint health.',
        'price': 599.0,
        'category': 'Healthcare',
        'images': ['https://via.placeholder.com/400x400?text=Vitamins'],
        'rating': 4.7,
        'reviewCount': 103,
        'stock': 55,
        'isAvailable': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    ];

    try {
      for (final product in products) {
        await _firestore.collection('products').add(product);
      }
      debugPrint('✅ Products seeded successfully');
    } catch (e) {
      debugPrint('❌ Error seeding products: $e');
    }
  }
}
