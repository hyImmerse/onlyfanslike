import 'package:creator_platform_demo/domain/entities/payment_history.dart';
import 'package:creator_platform_demo/domain/repositories/payment_history_repository.dart';

class MockPaymentHistoryRepository implements PaymentHistoryRepository {
  static final List<PaymentHistory> _mockPaymentHistory = [
    // 최근 결제들 (User 1 - john@example.com)
    PaymentHistory(
      id: 'pay_001',
      userId: '1',
      creatorId: 'c2',
      subscriptionId: 'sub_3',
      contentId: null,
      type: PaymentType.subscription,
      method: PaymentMethod.creditCard,
      status: PaymentStatus.completed,
      amount: 12990,
      currency: 'KRW',
      title: 'ArtMaster 구독',
      description: '아트마스터 월 구독권',
      transactionId: 'txn_001_202412',
      receiptUrl: 'https://receipt.example.com/txn_001_202412',
      metadata: {
        'plan_name': 'Basic Plan',
        'billing_cycle': 'monthly',
      },
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    
    PaymentHistory(
      id: 'pay_002',
      userId: '1',
      creatorId: 'c1',
      subscriptionId: null,
      contentId: 'content_premium_01',
      type: PaymentType.oneTimePayment,
      method: PaymentMethod.digitalWallet,
      status: PaymentStatus.completed,
      amount: 5000,
      currency: 'KRW',
      title: 'TechGuru 프리미엄 강의',
      description: 'React 고급 패턴 완전정복',
      transactionId: 'txn_002_202412',
      receiptUrl: 'https://receipt.example.com/txn_002_202412',
      metadata: {
        'content_type': 'video',
        'duration': '2시간 30분',
      },
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    
    PaymentHistory(
      id: 'pay_003',
      userId: '1',
      creatorId: 'c3',
      subscriptionId: null,
      contentId: null,
      type: PaymentType.tip,
      method: PaymentMethod.creditCard,
      status: PaymentStatus.completed,
      amount: 10000,
      currency: 'KRW',
      title: 'FitnessCoach 후원',
      description: '훌륭한 운동 영상에 대한 후원',
      transactionId: 'txn_003_202412',
      receiptUrl: 'https://receipt.example.com/txn_003_202412',
      metadata: {
        'tip_message': '좋은 영상 감사합니다!',
      },
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    
    // 지난달 결제들
    PaymentHistory(
      id: 'pay_004',
      userId: '1',
      creatorId: 'c2',
      subscriptionId: 'sub_3',
      contentId: null,
      type: PaymentType.subscription,
      method: PaymentMethod.creditCard,
      status: PaymentStatus.completed,
      amount: 12990,
      currency: 'KRW',
      title: 'ArtMaster 구독',
      description: '아트마스터 월 구독권',
      transactionId: 'txn_004_202411',
      receiptUrl: 'https://receipt.example.com/txn_004_202411',
      metadata: {
        'plan_name': 'Basic Plan',
        'billing_cycle': 'monthly',
      },
      createdAt: DateTime.now().subtract(const Duration(days: 32)),
      updatedAt: DateTime.now().subtract(const Duration(days: 32)),
    ),
    
    PaymentHistory(
      id: 'pay_005',
      userId: '1',
      creatorId: 'c4',
      subscriptionId: null,
      contentId: 'content_music_01',
      type: PaymentType.oneTimePayment,
      method: PaymentMethod.bankTransfer,
      status: PaymentStatus.completed,
      amount: 3000,
      currency: 'KRW',
      title: 'MusicMaker 음원',
      description: '로파이 힙합 비트 팩',
      transactionId: 'txn_005_202411',
      receiptUrl: 'https://receipt.example.com/txn_005_202411',
      metadata: {
        'track_count': '5',
        'format': 'mp3',
      },
      createdAt: DateTime.now().subtract(const Duration(days: 40)),
      updatedAt: DateTime.now().subtract(const Duration(days: 40)),
    ),
    
    // 실패한 결제
    PaymentHistory(
      id: 'pay_006',
      userId: '1',
      creatorId: 'c5',
      subscriptionId: null,
      contentId: 'content_cooking_01',
      type: PaymentType.oneTimePayment,
      method: PaymentMethod.creditCard,
      status: PaymentStatus.failed,
      amount: 8000,
      currency: 'KRW',
      title: 'CookingChef 레시피북',
      description: '한식 요리 완전정복',
      transactionId: 'txn_006_202412',
      receiptUrl: null,
      failureReason: '카드 한도 초과',
      metadata: {
        'retry_count': '2',
      },
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    
    // 환불된 결제
    PaymentHistory(
      id: 'pay_007',
      userId: '1',
      creatorId: 'c1',
      subscriptionId: null,
      contentId: 'content_tech_01',
      type: PaymentType.oneTimePayment,
      method: PaymentMethod.creditCard,
      status: PaymentStatus.refunded,
      amount: 15000,
      currency: 'KRW',
      title: 'TechGuru 부트캠프',
      description: '풀스택 개발자 되기',
      transactionId: 'txn_007_202411',
      receiptUrl: 'https://receipt.example.com/txn_007_202411',
      refundedAt: DateTime.now().subtract(const Duration(days: 25)),
      metadata: {
        'refund_reason': '사용자 요청',
      },
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 25)),
    ),
    
    // User 2의 결제들
    PaymentHistory(
      id: 'pay_008',
      userId: '2',
      creatorId: 'c1',
      subscriptionId: 'sub_1',
      contentId: null,
      type: PaymentType.subscription,
      method: PaymentMethod.creditCard,
      status: PaymentStatus.completed,
      amount: 9990,
      currency: 'KRW',
      title: 'TechGuru 구독',
      description: '테크구루 월 구독권',
      transactionId: 'txn_008_202412',
      receiptUrl: 'https://receipt.example.com/txn_008_202412',
      metadata: {
        'plan_name': 'Basic Plan',
        'billing_cycle': 'monthly',
      },
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    
    PaymentHistory(
      id: 'pay_009',
      userId: '2',
      creatorId: 'c5',
      subscriptionId: 'sub_2',
      contentId: null,
      type: PaymentType.subscription,
      method: PaymentMethod.debitCard,
      status: PaymentStatus.completed,
      amount: 8990,
      currency: 'KRW',
      title: 'CookingChef 구독',
      description: '쿠킹셰프 월 구독권',
      transactionId: 'txn_009_202412',
      receiptUrl: 'https://receipt.example.com/txn_009_202412',
      metadata: {
        'plan_name': 'Basic Plan',
        'billing_cycle': 'monthly',
      },
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      updatedAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  @override
  Future<List<PaymentHistory>> getUserPaymentHistory(
    String userId, {
    int limit = 20,
    int offset = 0,
    PaymentStatus? status,
    PaymentType? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    var filtered = _mockPaymentHistory.where((payment) {
      if (payment.userId != userId) return false;
      if (status != null && payment.status != status) return false;
      if (type != null && payment.type != type) return false;
      if (startDate != null && payment.createdAt.isBefore(startDate)) return false;
      if (endDate != null && payment.createdAt.isAfter(endDate)) return false;
      return true;
    }).toList();
    
    // Sort by created date (newest first)
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    // Apply pagination
    final start = offset;
    final end = (start + limit).clamp(0, filtered.length);
    
    if (start >= filtered.length) return [];
    
    return filtered.sublist(start, end);
  }

  @override
  Future<List<PaymentHistory>> getCreatorPaymentHistory(
    String creatorId, {
    int limit = 20,
    int offset = 0,
    PaymentStatus? status,
    PaymentType? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    var filtered = _mockPaymentHistory.where((payment) {
      if (payment.creatorId != creatorId) return false;
      if (status != null && payment.status != status) return false;
      if (type != null && payment.type != type) return false;
      if (startDate != null && payment.createdAt.isBefore(startDate)) return false;
      if (endDate != null && payment.createdAt.isAfter(endDate)) return false;
      return true;
    }).toList();
    
    // Sort by created date (newest first)
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    // Apply pagination
    final start = offset;
    final end = (start + limit).clamp(0, filtered.length);
    
    if (start >= filtered.length) return [];
    
    return filtered.sublist(start, end);
  }

  @override
  Future<PaymentHistory?> getPaymentHistory(String paymentId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      return _mockPaymentHistory.firstWhere((payment) => payment.id == paymentId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<PaymentHistory>> getSubscriptionPaymentHistory(String subscriptionId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    return _mockPaymentHistory
        .where((payment) => payment.subscriptionId == subscriptionId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<PaymentStatistics> getUserPaymentStatistics(String userId) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    final userPayments = _mockPaymentHistory
        .where((payment) => payment.userId == userId)
        .toList();
    
    final now = DateTime.now();
    final thisMonth = DateTime(now.year, now.month);
    final lastMonth = DateTime(now.year, now.month - 1);
    
    final completedPayments = userPayments
        .where((p) => p.status == PaymentStatus.completed)
        .toList();
    
    final thisMonthPayments = completedPayments
        .where((p) => p.createdAt.isAfter(thisMonth))
        .toList();
    
    final lastMonthPayments = completedPayments
        .where((p) => 
          p.createdAt.isAfter(lastMonth) && 
          p.createdAt.isBefore(thisMonth))
        .toList();
    
    return PaymentStatistics(
      totalAmount: completedPayments.fold(0, (sum, p) => sum + p.amount),
      totalCount: completedPayments.length,
      thisMonthAmount: thisMonthPayments.fold(0, (sum, p) => sum + p.amount),
      thisMonthCount: thisMonthPayments.length,
      lastMonthAmount: lastMonthPayments.fold(0, (sum, p) => sum + p.amount),
      lastMonthCount: lastMonthPayments.length,
      averageAmount: completedPayments.isEmpty 
          ? 0.0 
          : completedPayments.fold(0, (sum, p) => sum + p.amount) / completedPayments.length,
      successRate: userPayments.isEmpty 
          ? 0.0 
          : completedPayments.length / userPayments.length,
      paymentsByMethod: _groupPaymentsByMethod(completedPayments),
      paymentsByType: _groupPaymentsByType(completedPayments),
      monthlyTrend: _generateMonthlyTrend(completedPayments),
    );
  }

  @override
  Future<PaymentStatistics> getCreatorPaymentStatistics(String creatorId) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    final creatorPayments = _mockPaymentHistory
        .where((payment) => payment.creatorId == creatorId)
        .toList();
    
    final now = DateTime.now();
    final thisMonth = DateTime(now.year, now.month);
    final lastMonth = DateTime(now.year, now.month - 1);
    
    final completedPayments = creatorPayments
        .where((p) => p.status == PaymentStatus.completed)
        .toList();
    
    final thisMonthPayments = completedPayments
        .where((p) => p.createdAt.isAfter(thisMonth))
        .toList();
    
    final lastMonthPayments = completedPayments
        .where((p) => 
          p.createdAt.isAfter(lastMonth) && 
          p.createdAt.isBefore(thisMonth))
        .toList();
    
    return PaymentStatistics(
      totalAmount: completedPayments.fold(0, (sum, p) => sum + p.amount),
      totalCount: completedPayments.length,
      thisMonthAmount: thisMonthPayments.fold(0, (sum, p) => sum + p.amount),
      thisMonthCount: thisMonthPayments.length,
      lastMonthAmount: lastMonthPayments.fold(0, (sum, p) => sum + p.amount),
      lastMonthCount: lastMonthPayments.length,
      averageAmount: completedPayments.isEmpty 
          ? 0.0 
          : completedPayments.fold(0, (sum, p) => sum + p.amount) / completedPayments.length,
      successRate: creatorPayments.isEmpty 
          ? 0.0 
          : completedPayments.length / creatorPayments.length,
      paymentsByMethod: _groupPaymentsByMethod(completedPayments),
      paymentsByType: _groupPaymentsByType(completedPayments),
      monthlyTrend: _generateMonthlyTrend(completedPayments),
    );
  }

  @override
  Future<PaymentHistory> createPaymentHistory(PaymentHistory paymentHistory) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Generate new ID
    final newId = 'pay_${DateTime.now().millisecondsSinceEpoch}';
    final newPayment = paymentHistory.copyWith(
      id: newId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _mockPaymentHistory.add(newPayment);
    return newPayment;
  }

  @override
  Future<PaymentHistory> processRefund(String paymentId, String reason) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    final paymentIndex = _mockPaymentHistory.indexWhere((p) => p.id == paymentId);
    if (paymentIndex == -1) {
      throw Exception('결제 내역을 찾을 수 없습니다.');
    }
    
    final payment = _mockPaymentHistory[paymentIndex];
    if (payment.status != PaymentStatus.completed) {
      throw Exception('완료된 결제만 환불할 수 있습니다.');
    }
    
    final refundedPayment = payment.copyWith(
      status: PaymentStatus.refunded,
      refundedAt: DateTime.now(),
      updatedAt: DateTime.now(),
      metadata: {
        ...?payment.metadata,
        'refund_reason': reason,
      },
    );
    
    _mockPaymentHistory[paymentIndex] = refundedPayment;
    return refundedPayment;
  }

  // Helper methods
  Map<PaymentMethod, int> _groupPaymentsByMethod(List<PaymentHistory> payments) {
    final grouped = <PaymentMethod, int>{};
    for (final payment in payments) {
      grouped[payment.method] = (grouped[payment.method] ?? 0) + payment.amount;
    }
    return grouped;
  }

  Map<PaymentType, int> _groupPaymentsByType(List<PaymentHistory> payments) {
    final grouped = <PaymentType, int>{};
    for (final payment in payments) {
      grouped[payment.type] = (grouped[payment.type] ?? 0) + payment.amount;
    }
    return grouped;
  }

  List<MonthlyPayment> _generateMonthlyTrend(List<PaymentHistory> payments) {
    final grouped = <String, List<PaymentHistory>>{};
    
    for (final payment in payments) {
      final key = '${payment.createdAt.year}-${payment.createdAt.month}';
      grouped[key] = (grouped[key] ?? [])..add(payment);
    }
    
    final trend = <MonthlyPayment>[];
    for (final entry in grouped.entries) {
      final parts = entry.key.split('-');
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final amount = entry.value.fold(0, (sum, p) => sum + p.amount);
      
      trend.add(MonthlyPayment(
        year: year,
        month: month,
        amount: amount,
        count: entry.value.length,
      ));
    }
    
    // Sort by year and month
    trend.sort((a, b) {
      final aDate = DateTime(a.year, a.month);
      final bDate = DateTime(b.year, b.month);
      return aDate.compareTo(bDate);
    });
    
    return trend;
  }
}