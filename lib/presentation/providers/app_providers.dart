import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repository Providers
export 'repository_providers.dart';

// Authentication Providers
export 'auth_provider.dart';

/// App Providers - Central export file for all providers
/// 
/// This file serves as the main entry point for all providers in the application.
/// It re-exports all provider modules to provide a clean, organized way to import providers.
/// 
/// Usage:
/// ```dart
/// import 'package:creator_platform_demo/presentation/providers/app_providers.dart';
/// 
/// // Now you can access all providers:
/// // - Repository providers: RepositoryProviders.user, RepositoryProviders.creator, etc.
/// // - Auth providers: authStateNotifierProvider, isAuthenticatedProvider, etc.
/// ```

/// Global App State Providers
/// These providers manage application-wide state and configuration

/// App Theme Provider
final appThemeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

/// App Loading State Provider
/// Manages global loading states across the application
final globalLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

/// Navigation State Provider
/// Tracks current navigation state and history
final navigationStateProvider = StateProvider<String>((ref) {
  return '/'; // Default to home route
});

/// Error Handler Provider
/// Centralized error handling and reporting
final globalErrorProvider = StateProvider<String?>((ref) {
  return null;
});

/// Network Status Provider
/// Tracks online/offline status (for future implementation)
final networkStatusProvider = StateProvider<bool>((ref) {
  return true; // Assume online by default
});

/// Demo Mode Provider
/// Controls demo-specific features and behaviors
final demoModeProvider = StateProvider<bool>((ref) {
  return true; // Enable demo mode by default
});

/// App Providers Container
/// Provides organized access to all app-level providers
class AppProviders {
  // Theme and UI
  static final theme = appThemeProvider;
  static final globalLoading = globalLoadingProvider;
  static final navigationState = navigationStateProvider;
  
  // Error handling
  static final globalError = globalErrorProvider;
  
  // System state
  static final networkStatus = networkStatusProvider;
  static final demoMode = demoModeProvider;
}