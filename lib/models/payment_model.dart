class PaymentModel {
  final String id;
  final String bookingId;
  final double amount;
  final String status; // success, failed, pending, refunded
  final String paymentMethod; // razorpay, cash, card
  final String? transactionId;
  final String? orderId;
  final String? signature;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? failureReason;
  final Map<String, dynamic>? metadata;

  PaymentModel({
    required this.id,
    required this.bookingId,
    required this.amount,
    required this.status,
    required this.paymentMethod,
    this.transactionId,
    this.orderId,
    this.signature,
    required this.createdAt,
    this.updatedAt,
    this.failureReason,
    this.metadata,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map, String id) {
    return PaymentModel(
      id: id,
      bookingId: map['bookingId'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      status: map['status'] ?? 'pending',
      paymentMethod: map['paymentMethod'] ?? 'razorpay',
      transactionId: map['transactionId'],
      orderId: map['orderId'],
      signature: map['signature'],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : null,
      failureReason: map['failureReason'],
      metadata: map['metadata'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'amount': amount,
      'status': status,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
      'orderId': orderId,
      'signature': signature,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'failureReason': failureReason,
      'metadata': metadata,
    };
  }

  PaymentModel copyWith({
    String? id,
    String? bookingId,
    double? amount,
    String? status,
    String? paymentMethod,
    String? transactionId,
    String? orderId,
    String? signature,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? failureReason,
    Map<String, dynamic>? metadata,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      bookingId: bookingId ?? this.bookingId,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId ?? this.transactionId,
      orderId: orderId ?? this.orderId,
      signature: signature ?? this.signature,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      failureReason: failureReason ?? this.failureReason,
      metadata: metadata ?? this.metadata,
    );
  }
}
