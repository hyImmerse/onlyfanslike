import 'package:flutter/material.dart';

/// 메시지 입력 컴포넌트
class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final VoidCallback onSend;
  final VoidCallback onAttachment;
  final bool enabled;
  
  const MessageInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onSubmitted,
    required this.onSend,
    required this.onAttachment,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Attachment button
              IconButton(
                icon: Icon(
                  Icons.attach_file,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                onPressed: enabled ? onAttachment : null,
                tooltip: '파일 첨부',
              ),
              
              // Message input field
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 40,
                    maxHeight: 120,
                  ),
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    onChanged: onChanged,
                    onSubmitted: enabled ? onSubmitted : null,
                    enabled: enabled,
                    textInputAction: TextInputAction.send,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요...',
                      hintStyle: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                    ),
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ),
              
              const SizedBox(width: 4),
              
              // Send button
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: controller.text.trim().isEmpty ? 0 : 48,
                child: controller.text.trim().isEmpty
                    ? const SizedBox.shrink()
                    : IconButton(
                        icon: Icon(
                          Icons.send,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: enabled ? onSend : null,
                        tooltip: '전송',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}