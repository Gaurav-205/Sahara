import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MyPetsScreen extends StatefulWidget {
  const MyPetsScreen({super.key});

  @override
  State<MyPetsScreen> createState() => _MyPetsScreenState();
}

class _MyPetsScreenState extends State<MyPetsScreen> {
  final List<Pet> _pets = [
    Pet(
      id: '1',
      name: 'Max',
      type: 'Dog',
      breed: 'Golden Retriever',
      age: 3,
      weight: 30.0,
    ),
    Pet(
      id: '2',
      name: 'Luna',
      type: 'Cat',
      breed: 'Persian',
      age: 2,
      weight: 4.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text(
          'My Pets',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              _showAddPetDialog();
            },
          ),
        ],
      ),
      body: _pets.isEmpty ? _buildEmptyState() : _buildPetsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.pets_rounded,
              size: 52,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No pets added yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Add your first pet to get started',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showAddPetDialog,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: const Text('Add Pet'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.textPrimary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _pets.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _buildPetCard(_pets[index]),
        );
      },
    );
  }

  Widget _buildPetCard(Pet pet) {
    IconData petIcon;
    Color petColor;

    switch (pet.type.toLowerCase()) {
      case 'dog':
        petIcon = Icons.pets_rounded;
        petColor = AppColors.primary;
        break;
      case 'cat':
        petIcon = Icons.pets_rounded;
        petColor = AppColors.secondary;
        break;
      case 'bird':
        petIcon = Icons.flutter_dash_rounded;
        petColor = AppColors.accent;
        break;
      default:
        petIcon = Icons.pets_rounded;
        petColor = AppColors.tertiary;
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: petColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              petIcon,
              size: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${pet.breed} • ${pet.age} years old',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${pet.weight} kg',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert_rounded, color: Colors.grey[600]),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_rounded, size: 18),
                    SizedBox(width: 10),
                    Text(
                      'Edit',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_rounded, size: 18, color: Color(0xFFE53935)),
                    SizedBox(width: 10),
                    Text(
                      'Delete',
                      style: TextStyle(
                        color: Color(0xFFE53935),
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteDialog(pet);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showAddPetDialog() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final breedController = TextEditingController();
    final ageController = TextEditingController();
    final weightController = TextEditingController();
    String selectedType = 'Dog';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Add Pet',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  style: const TextStyle(fontFamily: 'Montserrat'),
                  decoration: InputDecoration(
                    labelText: 'Pet Name',
                    labelStyle: const TextStyle(fontFamily: 'Montserrat'),
                    prefixIcon: const Icon(Icons.pets_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pet name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedType,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Pet Type',
                    labelStyle: const TextStyle(fontFamily: 'Montserrat'),
                    prefixIcon: const Icon(Icons.category_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: ['Dog', 'Cat', 'Bird', 'Other']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      selectedType = value;
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: breedController,
                  style: const TextStyle(fontFamily: 'Montserrat'),
                  decoration: InputDecoration(
                    labelText: 'Breed',
                    labelStyle: const TextStyle(fontFamily: 'Montserrat'),
                    prefixIcon: const Icon(Icons.info_outline_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter breed';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: ageController,
                  style: const TextStyle(fontFamily: 'Montserrat'),
                  decoration: InputDecoration(
                    labelText: 'Age (years)',
                    labelStyle: const TextStyle(fontFamily: 'Montserrat'),
                    prefixIcon: const Icon(Icons.cake_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter age';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: weightController,
                  style: const TextStyle(fontFamily: 'Montserrat'),
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    labelStyle: const TextStyle(fontFamily: 'Montserrat'),
                    prefixIcon: const Icon(Icons.monitor_weight_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter weight';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              nameController.dispose();
              breedController.dispose();
              ageController.dispose();
              weightController.dispose();
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: AppColors.textPrimary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newPet = Pet(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  type: selectedType,
                  breed: breedController.text,
                  age: int.parse(ageController.text),
                  weight: double.parse(weightController.text),
                );

                setState(() {
                  _pets.add(newPet);
                });

                nameController.dispose();
                breedController.dispose();
                ageController.dispose();
                weightController.dispose();
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${newPet.name} added successfully!'),
                    backgroundColor: AppColors.textPrimary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.textPrimary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Add',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(Pet pet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Delete Pet',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to remove ${pet.name}?',
          style: const TextStyle(fontFamily: 'Montserrat'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: AppColors.textPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _pets.remove(pet);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${pet.name} removed'),
                  backgroundColor: const Color(0xFFE53935),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Color(0xFFE53935),
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Pet {
  final String id;
  final String name;
  final String type;
  final String breed;
  final int age;
  final double weight;

  Pet({
    required this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.weight,
  });
}
