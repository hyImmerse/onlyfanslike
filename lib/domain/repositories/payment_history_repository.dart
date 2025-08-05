import 'package:creator_platform_demo/domain/entities/payment_history.dart';

abstract class PaymentHistoryRepository {
  /// 특정 사용자의 결제 내역 조회
  Future<List<PaymentHistory>> getUserPaymentHistory(String userId, {
    int limit = 20,
    int offset = 0,
    PaymentStatus? status,
    PaymentType? type,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// 특정 크리에이터의 수익 내역 조회
  Future<List<PaymentHistory>> getCreatorPaymentHistory(String creatorId, {
    int limit = 20,
    int offset = 0,
    PaymentStatus? status,
    PaymentType? type,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// 특정 결제 내역 상세 조회
  Future<PaymentHistory?> getPaymentHistory(String paymentId);
  
  /// 구독 관련 결제 내역 조회
  Future<List<PaymentHistory>> getSubscriptionPaymentHistory(String subscriptionId);
  
  /// 사용자 결제 통계 조회
  Future<PaymentStatistics> getUserPaymentStatistics(String userId);
  
  /// 크리에이터 수익 통계 조회
  Future<PaymentStatistics> getCreatorPaymentStatistics(String creatorId);
  
  /// 결제 내역 생성 (Mock 데모용)
  Future<PaymentHistory> createPaymentHistory(PaymentHistory paymentHistory);
  
  /// 환불 처리
  Future<PaymentHistory> processRefund(String paymentId, String reason);
}

/// 결제 통계 클래스
class PaymentStatistics {
  const PaymentStatistics({
    required this.totalAmount,
    required this.totalCount,
    required this.thisMonthAmount,
    required this.thisMonthCount,
    required this.lastMonthAmount,
    required this.lastMonthCount,
    required this.averageAmount,
    required this.successRate,
    required this.paymentsByMethod,
    required this.paymentsByType,
    required this.monthlyTrend,
  });

  final int totalAmount;
  final int totalCount;
  final int thisMonthAmount;
  final int thisMonthCount;
  final int lastMonthAmount;
  final int lastMonthCount;
  final double averageAmount;
  final double successRate;
  final Map<PaymentMethod, int> paymentsByMethod;
  final Map<PaymentType, int> paymentsByType;
  final List<MonthlyPayment> monthlyTrend;
}

/// 월별 결제 데이터
class MonthlyPayment {
  const MonthlyPayment({
    required this.year,
    required this.month,
    required this.amount,
    required this.count,
  });

  final int year;
  final int month;
  final int amount;
  final int count;
  
  String get monthName {
    const months = [
      '', '1월', '2월', '3월', '4월', '5월', '6월',
      '7월', '8월', '9월', '10월', '11월', '12월'
    ];
    return months[month];
  }
}