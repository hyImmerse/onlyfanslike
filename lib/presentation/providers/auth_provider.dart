import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/presentation/providers/auth_state_notifier.dart';
import 'package:creator_platform_demo/presentation/providers/repository_providers.dart';

/// Authentication State Provider
final authStateNotifierProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final userRepository = ref.watch(RepositoryProviders.user);
  return AuthStateNotifier(userRepository);
});

/// Convenience providers for common auth checks
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.isAuthenticated;
});

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.isLoading;
});

final currentUserProvider = Provider((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.user;
});

final authErrorProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.errorMessage;
});