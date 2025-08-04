import 'package:flutter/material.dart';

class ContentViewerScreen extends StatelessWidget {
  final String contentId;
  
  const ContentViewerScreen({super.key, required this.contentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('콘텐츠')),
      body: Center(
        child: Text('Content Viewer - Content ID: $contentId'),
      ),
    );
  }
}