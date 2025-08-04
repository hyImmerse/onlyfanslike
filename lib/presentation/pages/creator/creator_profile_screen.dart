import 'package:flutter/material.dart';

class CreatorProfileScreen extends StatelessWidget {
  final String creatorId;
  
  const CreatorProfileScreen({super.key, required this.creatorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('크리에이터 프로필')),
      body: Center(
        child: Text('Creator Profile Screen - ID: $creatorId'),
      ),
    );
  }
}