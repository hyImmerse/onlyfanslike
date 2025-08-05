import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_history.freezed.dart';
part 'payment_history.g.dart';

enum PaymentStatus { 
  pending, 
  completed, 
  failed, 
  cancelled, 
  refunded 
}

enum PaymentType { 
  subscription, 
  oneTimePayment, 
  tip, 
  refund 
}

enum PaymentMethod { 
  creditCard, 
  debitCard, 
  bankTransfer, 
  digitalWallet, 
  inAppPurchase 
}

/// PaymentStatus 한국어 표시 확장
extension PaymentStatusExtension on PaymentStatus {
  String get displayName {
    switch (this) {
      case PaymentStatus.pending:
        return '결제 진행중';
      case PaymentStatus.completed:
        return '결제 완료';
      case PaymentStatus.failed:
        return '결제 실패';
      case PaymentStatus.cancelled:
        return '결제 취소';
      case PaymentStatus.refunded:
        return '환불 완료';
    }
  }
}

/// PaymentType 한국어 표시 확장
extension PaymentTypeExtension on PaymentType {
  String get displayName {
    switch (this) {
      case PaymentType.subscription:
        return '구독';
      case PaymentType.oneTimePayment:
        return '일회성 결제';
      case PaymentType.tip:
        return '후원';
      case PaymentType.refund:
        return '환불';
    }
  }
}

/// PaymentMethod 한국어 표시 확장
extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.creditCard:
        return '신용카드';
      case PaymentMethod.debitCard:
        return '체크카드';
      case PaymentMethod.bankTransfer:
        return '계좌이체';
      case PaymentMethod.digitalWallet:
        return '디지털 지갑';
      case PaymentMethod.inAppPurchase:
        return '인앱결제';
    }
  }
}

@freezed
class PaymentHistory with _$PaymentHistory {
  const factory PaymentHistory({
    required String id,
    required String userId,
    required String? creatorId,
    required String? subscriptionId,
    required String? contentId,
    required PaymentType type,
    required PaymentMethod method,
    required PaymentStatus status,
    required int amount, // 원 단위 (KRW)
    required String currency,
    required String title,
    required String description,
    String? transactionId,
    String? receiptUrl,
    Map<String, dynamic>? metadata,
    String? failureReason,
    DateTime? refundedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PaymentHistory;
  
  factory PaymentHistory.fromJson(Map<String, dynamic> json) => 
      _$PaymentHistoryFromJson(json);
}

// Extension for convenient getters
extension PaymentHistoryExtension on PaymentHistory {
  /// 성공한 결제인지 확인
  bool get isSuccessful => status == PaymentStatus.completed;
  
  /// 실패한 결제인지 확인
  bool get isFailed => status == PaymentStatus.failed;
  
  /// 환불된 결제인지 확인
  bool get isRefunded => status == PaymentStatus.refunded;
  
  /// 진행 중인 결제인지 확인
  bool get isPending => status == PaymentStatus.pending;
  
  /// 금액을 원화 형태로 포맷팅
  String get formattedAmount => '${amount.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), 
    (Match m) => '${m[1]},'
  )}원';
  
  /// 결제 방법을 한국어로 표시
  String get paymentMethodName {
    switch (method) {
      case PaymentMethod.creditCard:
        return '신용카드';
      case PaymentMethod.debitCard:
        return '체크카드';
      case PaymentMethod.bankTransfer:
        return '계좌이체';
      case PaymentMethod.digitalWallet:
        return '디지털 지갑';
      case PaymentMethod.inAppPurchase:
        return '인앱결제';
    }
  }
  
  /// 결제 타입을 한국어로 표시
  String get paymentTypeName {
    switch (type) {
      case PaymentType.subscription:
        return '구독';
      case PaymentType.oneTimePayment:
        return '일회성 결제';
      case PaymentType.tip:
        return '후원';
      case PaymentType.refund:
        return '환불';
    }
  }
  
  /// 결제 상태를 한국어로 표시
  String get statusName {
    switch (status) {
      case PaymentStatus.pending:
        return '결제 진행중';
      case PaymentStatus.completed:
        return '결제 완료';
      case PaymentStatus.failed:
        return '결제 실패';
      case PaymentStatus.cancelled:
        return '결제 취소';
      case PaymentStatus.refunded:
        return '환불 완료';
    }
  }
}