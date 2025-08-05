import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:creator_platform_demo/domain/entities/payment_history.dart';
import 'package:creator_platform_demo/presentation/providers/payment_history_providers.dart';
import 'package:creator_platform_demo/presentation/providers/auth_provider.dart';

class PaymentHistoryScreen extends ConsumerStatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  ConsumerState<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends ConsumerState<PaymentHistoryScreen> {
  PaymentHistoryFilter _currentFilter = const PaymentHistoryFilter();
  bool _showFilters = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);
    
    if (!authState.isAuthenticated) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('결제 내역'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('로그인이 필요합니다.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('결제 내역'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            icon: Icon(
              _showFilters ? Icons.filter_list_off : Icons.filter_list,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showFilters) _buildFilterSection(),
          _buildStatisticsSection(),
          Expanded(
            child: _buildPaymentHistoryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '필터',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Status Filter
            const Text('결제 상태', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: PaymentStatus.values.map((status) {
                return FilterChip(
                  label: Text(status.displayName),
                  selected: _currentFilter.status == status,
                  onSelected: (selected) {
                    setState(() {
                      _currentFilter = _currentFilter.copyWith(
                        status: selected ? status : null,
                      );
                    });
                    _applyFilter();
                  },
                );
              }).toList(),
            ),
            
            const SizedBox(height: 16),
            
            // Type Filter
            const Text('결제 유형', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: PaymentType.values.map((type) {
                return FilterChip(
                  label: Text(type.displayName),
                  selected: _currentFilter.type == type,
                  onSelected: (selected) {
                    setState(() {
                      _currentFilter = _currentFilter.copyWith(
                        type: selected ? type : null,
                      );
                    });
                    _applyFilter();
                  },
                );
              }).toList(),
            ),
            
            const SizedBox(height: 16),
            
            // Date Range
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _selectStartDate(),
                    child: Text(
                      _currentFilter.startDate != null
                          ? DateFormat('yyyy-MM-dd').format(_currentFilter.startDate!)
                          : '시작 날짜',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('~'),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _selectEndDate(),
                    child: Text(
                      _currentFilter.endDate != null
                          ? DateFormat('yyyy-MM-dd').format(_currentFilter.endDate!)
                          : '종료 날짜',
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Reset Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentFilter = const PaymentHistoryFilter();
                  });
                  _applyFilter();
                },
                child: const Text('필터 초기화'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    final statisticsAsyncValue = ref.watch(userPaymentStatisticsProvider);

    return statisticsAsyncValue.when(
      data: (statistics) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '결제 통계',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      '총 결제 금액',
                      '${NumberFormat('#,###').format(statistics.totalAmount)}원',
                      Icons.payment,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      '결제 건수',
                      '${statistics.totalCount}건',
                      Icons.receipt_long,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      '이번 달',
                      '${NumberFormat('#,###').format(statistics.thisMonthAmount)}원',
                      Icons.calendar_today,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      '성공률',
                      '${(statistics.successRate * 100).toStringAsFixed(1)}%',
                      Icons.check_circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      loading: () => const Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, stackTrace) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('통계 로드 실패: $error'),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentHistoryList() {
    final paymentsAsyncValue = ref.watch(
      filteredUserPaymentHistoryProvider(_currentFilter),
    );

    return paymentsAsyncValue.when(
      data: (payments) {
        if (payments.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  '결제 내역이 없습니다.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(filteredUserPaymentHistoryProvider(_currentFilter));
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return _buildPaymentItem(payment);
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              '결제 내역을 불러올 수 없습니다.\n$error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(filteredUserPaymentHistoryProvider(_currentFilter));
              },
              child: const Text('다시 시도'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentItem(PaymentHistory payment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(payment.status),
          child: Icon(
            _getStatusIcon(payment.status),
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          payment.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(payment.description),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  payment.type.displayName,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  payment.method.displayName,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat('MM/dd HH:mm').format(payment.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${NumberFormat('#,###').format(payment.amount)}원',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: payment.status == PaymentStatus.completed
                    ? Colors.green
                    : payment.status == PaymentStatus.failed
                        ? Colors.red
                        : Colors.orange,
              ),
            ),
            Text(
              payment.status.displayName,
              style: TextStyle(
                fontSize: 12,
                color: _getStatusColor(payment.status),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        onTap: () => _showPaymentDetail(payment),
      ),
    );
  }

  Color _getStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.completed:
        return Colors.green;
      case PaymentStatus.failed:
        return Colors.red;
      case PaymentStatus.refunded:
        return Colors.orange;
      case PaymentStatus.pending:
        return Colors.blue;
      case PaymentStatus.cancelled:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.completed:
        return Icons.check;
      case PaymentStatus.failed:
        return Icons.close;
      case PaymentStatus.refunded:
        return Icons.refresh;
      case PaymentStatus.pending:
        return Icons.access_time;
      case PaymentStatus.cancelled:
        return Icons.cancel;
    }
  }

  void _applyFilter() {
    ref.invalidate(filteredUserPaymentHistoryProvider(_currentFilter));
  }

  Future<void> _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _currentFilter.startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if (date != null) {
      setState(() {
        _currentFilter = _currentFilter.copyWith(startDate: date);
      });
      _applyFilter();
    }
  }

  Future<void> _selectEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _currentFilter.endDate ?? DateTime.now(),
      firstDate: _currentFilter.startDate ?? DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if (date != null) {
      setState(() {
        _currentFilter = _currentFilter.copyWith(endDate: date);
      });
      _applyFilter();
    }
  }

  void _showPaymentDetail(PaymentHistory payment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => PaymentDetailBottomSheet(payment: payment),
    );
  }
}

class PaymentDetailBottomSheet extends StatelessWidget {
  const PaymentDetailBottomSheet({
    super.key,
    required this.payment,
  });

  final PaymentHistory payment;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '결제 상세',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      _buildDetailItem('결제 ID', payment.id),
                      _buildDetailItem('상품명', payment.title),
                      _buildDetailItem('설명', payment.description),
                      _buildDetailItem('결제 금액', '${NumberFormat('#,###').format(payment.amount)}원'),
                      _buildDetailItem('결제 방법', payment.method.displayName),
                      _buildDetailItem('결제 유형', payment.type.displayName),
                      _buildDetailItem('결제 상태', payment.status.displayName),
                      _buildDetailItem('결제 일시', DateFormat('yyyy-MM-dd HH:mm:ss').format(payment.createdAt)),
                      
                      if (payment.transactionId != null)
                        _buildDetailItem('거래 ID', payment.transactionId!),
                      
                      if (payment.failureReason != null)
                        _buildDetailItem('실패 사유', payment.failureReason!),
                      
                      if (payment.refundedAt != null)
                        _buildDetailItem('환불 일시', DateFormat('yyyy-MM-dd HH:mm:ss').format(payment.refundedAt!)),
                      
                      if (payment.receiptUrl != null) ...[
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // In a real app, open receipt URL
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('영수증 URL: ${payment.receiptUrl}')),
                              );
                            },
                            icon: const Icon(Icons.receipt),
                            label: const Text('영수증 보기'),
                          ),
                        ),
                      ],
                      
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('닫기'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}