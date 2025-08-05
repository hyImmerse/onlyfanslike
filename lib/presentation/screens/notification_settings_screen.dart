import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/app_notification.dart';
import 'package:creator_platform_demo/presentation/providers/repository_providers.dart';
import 'package:creator_platform_demo/presentation/widgets/app_bar_widget.dart';

/// 알림 설정 화면 - 사용자의 알림 수신 설정을 관리
class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends ConsumerState<NotificationSettingsScreen> {
  NotificationSettings? _settings;
  bool _isLoading = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() => _isLoading = true);
    try {
      final repository = ref.read(notificationRepositoryProvider);
      final settings = await repository.getUserNotificationSettings('1');
      setState(() {
        _settings = settings;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('설정을 불러오는데 실패했습니다: $e')),
        );
      }
    }
  }

  Future<void> _saveSettings() async {
    if (_settings == null) return;

    setState(() => _isSaving = true);
    try {
      final repository = ref.read(notificationRepositoryProvider);
      await repository.updateUserNotificationSettings('1', _settings!);
      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('설정이 저장되었습니다'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('설정 저장에 실패했습니다: $e')),
        );
      }
    }
  }

  void _updateSettings(NotificationSettings Function(NotificationSettings) updater) {
    if (_settings != null) {
      setState(() {
        _settings = updater(_settings!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '알림 설정',
        actions: [
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _saveSettings,
              child: const Text('저장'),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _settings == null
              ? _buildErrorState()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGeneralSettings(),
                      const SizedBox(height: 24),
                      _buildNotificationTypeSettings(),
                      const SizedBox(height: 24),
                      _buildQuietHoursSettings(),
                      const SizedBox(height: 24),
                      _buildAdvancedSettings(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            '설정을 불러올 수 없습니다',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadSettings,
            child: const Text('다시 시도'),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return _buildSection(
      title: '일반 설정',
      children: [
        _buildSwitchTile(
          title: '푸시 알림',
          subtitle: '모바일 기기로 알림을 받습니다',
          value: _settings!.pushEnabled,
          onChanged: (value) {
            _updateSettings((settings) => settings.copyWith(pushEnabled: value));
          },
          icon: Icons.notifications,
        ),
        _buildSwitchTile(
          title: '이메일 알림',
          subtitle: '이메일로 알림을 받습니다',
          value: _settings!.emailEnabled,
          onChanged: (value) {
            _updateSettings((settings) => settings.copyWith(emailEnabled: value));
          },
          icon: Icons.email,
        ),
        _buildSwitchTile(
          title: '앱 내 알림',
          subtitle: '앱 실행 중 알림을 표시합니다',
          value: _settings!.inAppEnabled,
          onChanged: (value) {
            _updateSettings((settings) => settings.copyWith(inAppEnabled: value));
          },
          icon: Icons.notifications_active,
        ),
      ],
    );
  }

  Widget _buildNotificationTypeSettings() {
    return _buildSection(
      title: '알림 유형별 설정',
      children: [
        _buildSwitchTile(
          title: '결제 알림',
          subtitle: '결제 완료, 실패, 환불 등의 알림',
          value: _settings!.paymentEnabled,
          onChanged: (value) {
            _updateSettings((settings) => settings.copyWith(paymentEnabled: value));
          },
          icon: Icons.payment,
          iconColor: Colors.green,
        ),
        _buildSwitchTile(
          title: '구독 알림',
          subtitle: '구독 시작, 갱신, 만료 등의 알림',
          value: _settings!.subscriptionEnabled,
          onChanged: (value) {
            _updateSettings((settings) => settings.copyWith(subscriptionEnabled: value));
          },
          icon: Icons.subscriptions,
          iconColor: Colors.blue,
        ),
        _buildSwitchTile(
          title: '콘텐츠 알림',
          subtitle: '새 콘텐츠 업로드, 업데이트 알림',
          value: _settings!.contentEnabled,
          onChanged: (value) {
            _updateSettings((settings) => settings.copyWith(contentEnabled: value));
          },
          icon: Icons.video_library,
          iconColor: Colors.purple,
        ),
        _buildSwitchTile(
          title: '메시지 알림',
          subtitle: '크리에이터로부터의 메시지 알림',
          value: _settings!.messageEnabled,
          onChanged: (value) {
            _updateSettings((settings) => settings.copyWith(messageEnabled: value));
          },
          icon: Icons.message,
          iconColor: Colors.orange,
        ),
        _buildSwitchTile(
          title: '시스템 알림',
          subtitle: '서비스 업데이트, 점검 등의 알림',
          value: _settings!.systemEnabled,
          onChanged: (value) {
            _updateSettings((settings) => settings.copyWith(systemEnabled: value));
          },
          icon: Icons.settings,
          iconColor: Colors.grey,
        ),
        _buildSwitchTile(
          title: '크리에이터 활동 알림',
          subtitle: '라이브 방송, 이벤트 등의 알림',
          value: _settings!.creatorEnabled,
          onChanged: (value) {
            _updateSettings((settings) => settings.copyWith(creatorEnabled: value));
          },
          icon: Icons.person,
          iconColor: Colors.pink,
        ),
        _buildSwitchTile(
          title: '프로모션 알림',
          subtitle: '할인, 이벤트 등의 마케팅 알림',
          value: _settings!.promotionEnabled,
          onChanged: (value) {
            _updateSettings((settings) => settings.copyWith(promotionEnabled: value));
          },
          icon: Icons.local_offer,
          iconColor: Colors.amber,
        ),
      ],
    );
  }

  Widget _buildQuietHoursSettings() {
    return _buildSection(
      title: '방해 금지 시간',
      children: [
        _buildSwitchTile(
          title: '방해 금지 시간 설정',
          subtitle: '지정된 시간에는 알림을 받지 않습니다',
          value: _settings!.quietHoursEnabled,
          onChanged: (value) {
            _updateSettings((settings) => settings.copyWith(quietHoursEnabled: value));
          },
          icon: Icons.do_not_disturb,
        ),
        if (_settings!.quietHoursEnabled) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildTimeSelector(
                  label: '시작 시간',
                  time: _settings!.quietHoursStart,
                  onTimeSelected: (time) {
                    _updateSettings((settings) => settings.copyWith(quietHoursStart: time));
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTimeSelector(
                  label: '종료 시간',
                  time: _settings!.quietHoursEnd,
                  onTimeSelected: (time) {
                    _updateSettings((settings) => settings.copyWith(quietHoursEnd: time));
                  },
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildAdvancedSettings() {
    return _buildSection(
      title: '고급 설정',
      children: [
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('알림 기록 삭제'),
          subtitle: const Text('30일 이상 된 알림 기록을 삭제합니다'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showCleanupDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.backup),
          title: const Text('설정 백업'),
          subtitle: const Text('알림 설정을 클라우드에 백업합니다'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showBackupDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.restore),
          title: const Text('기본값으로 복원'),
          subtitle: const Text('모든 알림 설정을 기본값으로 되돌립니다'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showResetDialog(),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required IconData icon,
    Color? iconColor,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      secondary: Icon(icon, color: iconColor),
    );
  }

  Widget _buildTimeSelector({
    required String label,
    required String time,
    required Function(String) onTimeSelected,
  }) {
    return InkWell(
      onTap: () async {
        final timeParts = time.split(':');
        final initialTime = TimeOfDay(
          hour: int.parse(timeParts[0]),
          minute: int.parse(timeParts[1]),
        );

        final selectedTime = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );

        if (selectedTime != null) {
          final timeString = '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
          onTimeSelected(timeString);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCleanupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('알림 기록 삭제'),
        content: const Text('30일 이상 된 알림 기록을 영구적으로 삭제합니다. 계속하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: 알림 기록 삭제 구현
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('알림 기록이 삭제되었습니다'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('설정 백업'),
        content: const Text('현재 알림 설정을 클라우드에 백업하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: 설정 백업 구현
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('설정이 백업되었습니다'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('백업'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('기본값으로 복원'),
        content: const Text('모든 알림 설정이 기본값으로 되돌려집니다. 계속하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: 기본값 복원 구현
              _loadSettings(); // 임시로 다시 로드
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('설정이 기본값으로 복원되었습니다'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('복원'),
          ),
        ],
      ),
    );
  }
}