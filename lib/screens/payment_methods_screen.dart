import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: '1',
      type: PaymentType.card,
      last4: '4242',
      brand: 'Visa',
      expiryMonth: 12,
      expiryYear: 2025,
      isDefault: true,
    ),
    PaymentMethod(
      id: '2',
      type: PaymentType.card,
      last4: '5555',
      brand: 'Mastercard',
      expiryMonth: 6,
      expiryYear: 2026,
      isDefault: false,
    ),
  ];

  void _setDefaultPaymentMethod(String id) {
    setState(() {
      for (var method in _paymentMethods) {
        method.isDefault = method.id == id;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Default payment method updated'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _deletePaymentMethod(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Payment Method'),
        content: const Text('Are you sure you want to delete this payment method?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _paymentMethods.removeWhere((m) => m.id == id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment method deleted'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _addPaymentMethod() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AddPaymentMethodSheet(
        onAdd: (method) {
          setState(() {
            _paymentMethods.add(method);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment method added'),
              backgroundColor: AppColors.success,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Payment Methods'),
        backgroundColor: AppColors.surface,
      ),
      body: _paymentMethods.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: _paymentMethods.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildPaymentMethodCard(_paymentMethods[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addPaymentMethod,
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Card'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.credit_card_off_rounded,
            size: 80,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'No payment methods',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add a payment method to book services',
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(PaymentMethod method) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getIconForBrand(method.brand),
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${method.brand} •••• ${method.last4}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    if (method.isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Default',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Expires ${method.expiryMonth.toString().padLeft(2, '0')}/${method.expiryYear}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (value) {
              if (value == 'default') {
                _setDefaultPaymentMethod(method.id);
              } else if (value == 'delete') {
                _deletePaymentMethod(method.id);
              }
            },
            itemBuilder: (context) => [
              if (!method.isDefault)
                const PopupMenuItem(
                  value: 'default',
                  child: Text('Set as default'),
                ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete', style: TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIconForBrand(String brand) {
    switch (brand.toLowerCase()) {
      case 'visa':
        return Icons.credit_card_rounded;
      case 'mastercard':
        return Icons.credit_card_rounded;
      case 'amex':
        return Icons.credit_card_rounded;
      default:
        return Icons.payment_rounded;
    }
  }
}

class _AddPaymentMethodSheet extends StatefulWidget {
  final Function(PaymentMethod) onAdd;

  const _AddPaymentMethodSheet({required this.onAdd});

  @override
  State<_AddPaymentMethodSheet> createState() => _AddPaymentMethodSheetState();
}

class _AddPaymentMethodSheetState extends State<_AddPaymentMethodSheet> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _addCard() {
    if (_formKey.currentState!.validate()) {
      final cardNumber = _cardNumberController.text.replaceAll(' ', '');
      final last4 = cardNumber.substring(cardNumber.length - 4);
      final expiry = _expiryController.text.split('/');
      
      final method = PaymentMethod(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: PaymentType.card,
        last4: last4,
        brand: _detectCardBrand(cardNumber),
        expiryMonth: int.parse(expiry[0]),
        expiryYear: int.parse('20${expiry[1]}'),
        isDefault: false,
      );

      widget.onAdd(method);
      Navigator.pop(context);
    }
  }

  String _detectCardBrand(String cardNumber) {
    if (cardNumber.startsWith('4')) return 'Visa';
    if (cardNumber.startsWith('5')) return 'Mastercard';
    if (cardNumber.startsWith('3')) return 'Amex';
    return 'Card';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Payment Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  hintText: '1234 5678 9012 3456',
                  prefixIcon: Icon(Icons.credit_card_rounded),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  }
                  final cleaned = value.replaceAll(' ', '');
                  if (cleaned.length < 13 || cleaned.length > 19) {
                    return 'Invalid card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryController,
                      decoration: const InputDecoration(
                        labelText: 'Expiry',
                        hintText: 'MM/YY',
                        prefixIcon: Icon(Icons.calendar_today_rounded),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                          return 'Invalid format';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        hintText: '123',
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (value.length < 3 || value.length > 4) {
                          return 'Invalid CVV';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Cardholder Name',
                  hintText: 'John Doe',
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cardholder name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _addCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Add Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethod {
  final String id;
  final PaymentType type;
  final String last4;
  final String brand;
  final int expiryMonth;
  final int expiryYear;
  bool isDefault;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.last4,
    required this.brand,
    required this.expiryMonth,
    required this.expiryYear,
    this.isDefault = false,
  });
}

enum PaymentType {
  card,
  paypal,
  applePay,
  googlePay,
}




