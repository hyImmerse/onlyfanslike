import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  final String creatorId;
  
  const SubscriptionScreen({super.key, required this.creatorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('구독하기')),
      body: Center(
        child: Text('Subscription Screen - Creator ID: $creatorId'),
      ),
    );
  }
}