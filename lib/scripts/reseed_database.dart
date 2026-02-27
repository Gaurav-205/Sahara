import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';
import '../utils/firebase_seeder_india.dart';

/// Re-seed Database Script
/// 
/// This script will:
/// 1. Clear all existing seeded data (caregivers and service packages)
/// 2. Re-seed with corrected service type names
/// 
/// Run this to fix the service type mismatch issue
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  print('🔥 Initializing Firebase...');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  final seeder = FirebaseSeederIndia();
  
  print('\n📊 Current database status:');
  await seeder.checkDatabaseStatus();
  
  print('\n🗑️  Clearing old seeded data...');
  await seeder.clearAllData();
  
  print('\n🌱 Re-seeding with corrected service types...');
  await seeder.seedAll();
  
  print('\n✅ Re-seeding complete!');
  print('\n📊 New database status:');
  await seeder.checkDatabaseStatus();
  
  print('\n🎉 Done! Service types are now correct:');
  print('   - Dog Walking ✅');
  print('   - Pet Sitting ✅');
  print('   - Grooming ✅');
  print('   - Training ✅ (was "Dog Training")');
  print('   - Vet Visit ✅');
}
