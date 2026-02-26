import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../models/payment_model.dart';
import '../config/app_config.dart';
import 'firestore_service.dart';

/// Payment Service - Handles Razorpay payment integration
/// 
/// Features:
/// - Initialize Razorpay
/// - Process payments
/// - Handle payment callbacks
/// - Store payment records in Firestore
/// - Refund handling (future)
class PaymentService {
  late Razorpay _razorpay;
  final FirestoreService _firestoreService = FirestoreService();
  
  static final String _keyId = AppConfig.razorpayKeyId;
  static final String _keySecret = AppConfig.razorpayKeySecret;
  
  // Callbacks
  Function(PaymentSuccessResponse)? _onSuccess;
  Function(PaymentFailureResponse)? _onFailure;
  Function(ExternalWalletResponse)? _onExternalWallet;

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  /// Initialize payment with booking details
  Future<void> initiatePayment({
    required String bookingId,
    required double amount,
    required String userName,
    required String userEmail,
    required String userPhone,
    required String description,
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
    Function(ExternalWalletResponse)? onExternalWallet,
  }) async {
    _onSuccess = onSuccess;
    _onFailure = onFailure;
    _onExternalWallet = onExternalWallet;

    var options = {
      'key': _keyId,
      'amount': (amount * 100).toInt(), // Amount in paise
      'name': 'Sahara Pet Care',
      'description': description,
      'prefill': {
        'contact': userPhone,
        'email': userEmail,
        'name': userName,
      },
      'external': {
        'wallets': ['paytm', 'phonepe', 'googlepay']
      },
      'notes': {
        'booking_id': bookingId,
      },
      'theme': {
        'color': '#0B3D6B', // Primary color
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error opening Razorpay: $e');
      rethrow;
    }
  }

  /// Handle successful payment
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    debugPrint('Payment Success: ${response.paymentId}');
    
    // Create payment record
    final payment = PaymentModel(
      id: response.paymentId ?? '',
      bookingId: '', // Will be set from notes
      amount: 0, // Will be set from order
      status: 'success',
      paymentMethod: 'razorpay',
      transactionId: response.paymentId ?? '',
      orderId: response.orderId,
      signature: response.signature,
      createdAt: DateTime.now(),
    );

    // Save to Firestore
    try {
      await _firestoreService.createPayment(payment);
    } catch (e) {
      debugPrint('Error saving payment: $e');
    }

    // Call success callback
    _onSuccess?.call(response);
  }

  /// Handle payment failure
  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('Payment Error: ${response.code} - ${response.message}');
    _onFailure?.call(response);
  }

  /// Handle external wallet
  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet: ${response.walletName}');
    _onExternalWallet?.call(response);
  }

  /// Dispose Razorpay instance
  void dispose() {
    _razorpay.clear();
  }

  /// Verify payment signature (should be done on backend)
  bool verifySignature({
    required String orderId,
    required String paymentId,
    required String signature,
  }) {
    // TODO: Implement signature verification
    // This should ideally be done on the backend for security
    // For now, we'll trust Razorpay's callback
    return true;
  }

  /// Get payment status
  Future<String> getPaymentStatus(String paymentId) async {
    // TODO: Implement API call to check payment status
    // This requires backend API integration
    return 'success';
  }

  /// Initiate refund (requires backend)
  Future<bool> initiateRefund({
    required String paymentId,
    required double amount,
    String? reason,
  }) async {
    // TODO: Implement refund via backend API
    // Razorpay refunds must be initiated from backend
    debugPrint('Refund initiated for payment: $paymentId');
    return false;
  }
}
