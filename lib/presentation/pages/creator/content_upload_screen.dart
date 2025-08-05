import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:creator_platform_demo/domain/entities/content.dart';
import 'package:creator_platform_demo/presentation/providers/content_providers.dart';
import 'package:creator_platform_demo/presentation/providers/auth_provider.dart';

/// 콘텐츠 업로드 화면
class ContentUploadScreen extends ConsumerStatefulWidget {
  const ContentUploadScreen({super.key});

  @override
  ConsumerState<ContentUploadScreen> createState() => _ContentUploadScreenState();
}

class _ContentUploadScreenState extends ConsumerState<ContentUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  // 파일 관련 상태
  PlatformFile? _selectedFile;
  String? _thumbnailPath;
  bool _isPublic = true;
  ContentType _contentType = ContentType.image;
  
  // 드래그앤드롭 상태
  bool _isDragging = false;
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uploadState = ref.watch(contentUploadProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('콘텐츠 업로드'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: uploadState.isLoading ? null : _handleUpload,
            child: const Text('업로드'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 드래그앤드롭 영역
              _buildDropZone(theme),
              
              const SizedBox(height: 24),
              
              // 파일 미리보기
              if (_selectedFile != null) ...[
                _buildFilePreview(theme),
                const SizedBox(height: 24),
              ],
              
              // 업로드 진행률
              if (uploadState.isLoading) ...[
                _buildUploadProgress(theme, uploadState.uploadProgress),
                const SizedBox(height: 24),
              ],
              
              // 콘텐츠 정보 입력
              _buildContentForm(theme),
              
              const SizedBox(height: 24),
              
              // 에러/성공 메시지
              if (uploadState.hasError)
                _buildErrorMessage(theme, uploadState.errorMessage ?? '업로드 실패'),
              
              if (uploadState.successMessage != null)
                _buildSuccessMessage(theme, uploadState.successMessage!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropZone(ThemeData theme) {
    return GestureDetector(
      onTap: _pickFile,
      child: DragTarget<Object>(
        onWillAccept: (data) => true,
        onAccept: (data) => _handleFileDrop(data),
        onMove: (details) {
          if (!_isDragging) {
            setState(() => _isDragging = true);
          }
        },
        onLeave: (data) {
          setState(() => _isDragging = false);
        },
        builder: (context, candidateData, rejectedData) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 200,
            decoration: BoxDecoration(
              color: _isDragging
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isDragging
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline,
                width: _isDragging ? 2 : 1,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _selectedFile != null ? Icons.check_circle : Icons.cloud_upload,
                  size: 48,
                  color: _selectedFile != null
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  _selectedFile != null
                      ? '파일이 선택됨: ${_selectedFile!.name}'
                      : _isDragging
                          ? '파일을 여기에 놓으세요'
                          : '파일을 드래그하거나 클릭하여 업로드',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: _selectedFile != null
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (_selectedFile == null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '지원 형식: 이미지, 비디오, 오디오',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilePreview(ThemeData theme) {
    if (_selectedFile == null) return const SizedBox();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _getFileIcon(theme),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedFile!.name,
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _formatFileSize(_selectedFile!.size),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedFile = null;
                    _thumbnailPath = null;
                  });
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          
          // 미리보기 (이미지, 비디오, 오디오)
          const SizedBox(height: 12),
          _buildFilePreviewContent(theme),
        ],
      ),
    );
  }

  Widget _buildUploadProgress(ThemeData theme, double progress) {
    final steps = ['파일 검증', '이미지 처리', '업로드', '메타데이터 저장', '완료'];
    final currentStep = (progress * steps.length).floor();
    final stepProgress = (progress * steps.length) - currentStep;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '업로드 진행중',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Progress Steps
          Row(
            children: steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;
              final isUpcoming = index > currentStep;
              
              return Expanded(
                child: Column(
                  children: [
                    // Step indicator
                    Row(
                      children: [
                        // Circle indicator
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted
                                ? theme.colorScheme.primary
                                : isCurrent
                                    ? theme.colorScheme.primary.withOpacity(0.3)
                                    : theme.colorScheme.outline.withOpacity(0.3),
                          ),
                          child: Center(
                            child: isCompleted
                                ? Icon(
                                    Icons.check,
                                    size: 14,
                                    color: theme.colorScheme.onPrimary,
                                  )
                                : isCurrent
                                    ? SizedBox(
                                        width: 12,
                                        height: 12,
                                        child: CircularProgressIndicator(
                                          value: stepProgress,
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            theme.colorScheme.primary,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: theme.colorScheme.outline,
                                        ),
                                      ),
                          ),
                        ),
                        
                        // Connecting line
                        if (index < steps.length - 1)
                          Expanded(
                            child: Container(
                              height: 2,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.outline.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Step label
                    Text(
                      step,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isCompleted || isCurrent
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onSurfaceVariant,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 16),
          
          // Current step description
          if (currentStep < steps.length)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      currentStep < steps.length
                          ? '현재 단계: ${steps[currentStep]}'
                          : '업로드 완료!',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContentForm(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목 입력
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: '제목',
            hintText: '콘텐츠 제목을 입력하세요',
            prefixIcon: Icon(Icons.title),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '제목을 입력해주세요';
            }
            return null;
          },
          maxLength: 100,
        ),
        
        const SizedBox(height: 16),
        
        // 설명 입력
        TextFormField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: '설명',
            hintText: '콘텐츠 설명을 입력하세요',
            prefixIcon: Icon(Icons.description),
          ),
          maxLines: 4,
          maxLength: 500,
        ),
        
        const SizedBox(height: 16),
        
        // 콘텐츠 타입 선택
        Text(
          '콘텐츠 타입',
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ContentType.values.map((type) {
            return ChoiceChip(
              label: Text(_getContentTypeLabel(type)),
              selected: _contentType == type,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _contentType = type);
                }
              },
            );
          }).toList(),
        ),
        
        const SizedBox(height: 16),
        
        // 공개 설정
        SwitchListTile(
          title: const Text('공개 콘텐츠'),
          subtitle: Text(_isPublic ? '모든 사용자가 볼 수 있습니다' : '구독자만 볼 수 있습니다'),
          value: _isPublic,
          onChanged: (value) {
            setState(() => _isPublic = value);
          },
        ),
      ],
    );
  }

  Widget _buildErrorMessage(ThemeData theme, String message) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessMessage(ThemeData theme, String message) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: theme.colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getFileIcon(ThemeData theme) {
    if (_selectedFile == null) return const Icon(Icons.file_present);
    
    final extension = path.extension(_selectedFile!.name).toLowerCase();
    IconData iconData;
    Color color;
    
    if (['.jpg', '.jpeg', '.png', '.gif', '.webp'].contains(extension)) {
      iconData = Icons.image;
      color = theme.colorScheme.primary;
    } else if (['.mp4', '.avi', '.mkv', '.mov'].contains(extension)) {
      iconData = Icons.video_file;
      color = theme.colorScheme.secondary;
    } else if (['.mp3', '.wav', '.aac', '.m4a'].contains(extension)) {
      iconData = Icons.audio_file;
      color = theme.colorScheme.tertiary;
    } else {
      iconData = Icons.insert_drive_file;
      color = theme.colorScheme.onSurfaceVariant;
    }
    
    return Icon(iconData, color: color, size: 32);
  }

  String _getContentTypeLabel(ContentType type) {
    switch (type) {
      case ContentType.image:
        return '이미지';
      case ContentType.video:
        return '비디오';
      case ContentType.audio:
        return '오디오';
      case ContentType.article:
        return '글';
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  bool _isImageFile(String fileName) {
    final extension = path.extension(fileName).toLowerCase();
    return ['.jpg', '.jpeg', '.png', '.gif', '.webp'].contains(extension);
  }

  bool _isVideoFile(String fileName) {
    final extension = path.extension(fileName).toLowerCase();
    return ['.mp4', '.avi', '.mkv', '.mov', '.webm'].contains(extension);
  }

  bool _isAudioFile(String fileName) {
    final extension = path.extension(fileName).toLowerCase();
    return ['.mp3', '.wav', '.aac', '.m4a', '.ogg'].contains(extension);
  }

  Widget _buildFilePreviewContent(ThemeData theme) {
    if (_selectedFile == null) return const SizedBox();
    
    final fileName = _selectedFile!.name;
    
    if (_isImageFile(fileName) && _selectedFile!.bytes != null) {
      // 이미지 미리보기
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          _selectedFile!.bytes!,
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallbackPreview(theme, Icons.broken_image, '이미지 미리보기 실패');
          },
        ),
      );
    } else if (_isVideoFile(fileName)) {
      // 비디오 미리보기
      return _buildVideoPreview(theme);
    } else if (_isAudioFile(fileName)) {
      // 오디오 미리보기
      return _buildAudioPreview(theme);
    } else {
      // 기타 파일
      return _buildFallbackPreview(theme, Icons.insert_drive_file, '미리보기 지원하지 않는 파일');
    }
  }

  Widget _buildVideoPreview(ThemeData theme) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 비디오 플레이스홀더
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.secondary.withOpacity(0.1),
                  theme.colorScheme.primary.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          
          // 재생 버튼 아이콘
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.play_arrow,
              size: 32,
              color: theme.colorScheme.primary,
            ),
          ),
          
          // 파일 정보
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withOpacity(0.9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.videocam,
                    size: 16,
                    color: theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '비디오 파일 • ${_formatFileSize(_selectedFile!.size)}',
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioPreview(ThemeData theme) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // 오디오 시각화 (파형 모방)
          Expanded(
            flex: 3,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.3),
                    theme.colorScheme.primary.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 파형 시뮬레이션
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(20, (index) {
                      final heights = [0.2, 0.6, 0.8, 0.4, 0.9, 0.3, 0.7, 0.5, 0.8, 0.6,
                                     0.4, 0.7, 0.9, 0.3, 0.6, 0.8, 0.4, 0.5, 0.7, 0.6];
                      return Container(
                        width: 2,
                        height: 40 * heights[index],
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      );
                    }),
                  ),
                  
                  // 재생 버튼
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // 오디오 정보
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.audiotrack,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '오디오',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _formatFileSize(_selectedFile!.size),
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 2),
                Text(
                  '재생시간: --:--',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackPreview(ThemeData theme, IconData icon, String message) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.media,
        allowMultiple: false,
        withData: true, // 웹에서 파일 데이터 가져오기
      );
      
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFile = result.files.first;
          _isDragging = false;
          
          // 콘텐츠 타입 자동 감지
          if (_isImageFile(_selectedFile!.name)) {
            _contentType = ContentType.image;
          } else if (_isVideoFile(_selectedFile!.name)) {
            _contentType = ContentType.video;
          } else if (_isAudioFile(_selectedFile!.name)) {
            _contentType = ContentType.audio;
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('파일 선택 중 오류가 발생했습니다: $e')),
      );
    }
  }

  void _handleFileDrop(Object data) async {
    setState(() => _isDragging = false);
    
    // Flutter Web에서 드래그앤드롭 처리
    try {
      if (data is List<dynamic> && data.isNotEmpty) {
        // 웹에서 드래그된 파일 처리
        await _pickFile();
      } else {
        // 대체 방법으로 파일 선택기 열기
        await _pickFile();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('파일 드롭 처리 중 오류: $e')),
      );
    }
  }

  Future<void> _handleUpload() async {
    if (!_formKey.currentState!.validate() || _selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('필수 정보를 입력하고 파일을 선택해주세요')),
      );
      return;
    }

    final user = ref.read(currentUserProvider);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인이 필요합니다')),
      );
      return;
    }

    // 파일 크기 제한 (50MB)
    const maxFileSize = 50 * 1024 * 1024;
    if (_selectedFile!.size > maxFileSize) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('파일 크기는 50MB 이하로 제한됩니다')),
      );
      return;
    }

    try {
      await ref.read(contentUploadProvider.notifier).uploadContent(
        creatorId: user.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        contentUrl: 'mock://content/${_selectedFile!.name}',
        thumbnailUrl: 'mock://thumbnail/${_selectedFile!.name}',
        type: _contentType,
        isPublic: _isPublic,
      );

      // 업로드 성공 시 폼 초기화
      if (mounted) {
        _titleController.clear();
        _descriptionController.clear();
        setState(() {
          _selectedFile = null;
          _thumbnailPath = null;
          _isPublic = true;
          _contentType = ContentType.image;
        });
      }
    } catch (e) {
      // 에러는 ContentUploadNotifier에서 처리됨
    }
  }
}