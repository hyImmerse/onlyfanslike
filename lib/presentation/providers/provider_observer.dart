import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

/// Custom Provider Observer for debugging and monitoring
/// 
/// This observer logs provider lifecycle events in debug mode,
/// helping with development and debugging of state management.
class AppProviderObserver extends ProviderObserver {
  const AppProviderObserver();

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint('🔄 Provider added: ${provider.name ?? provider.runtimeType}');
    }
    super.didAddProvider(provider, value, container);
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint('🗑️ Provider disposed: ${provider.name ?? provider.runtimeType}');
    }
    super.didDisposeProvider(provider, container);
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint('🔄 Provider updated: ${provider.name ?? provider.runtimeType}');
      debugPrint('   Previous: $previousValue');
      debugPrint('   New: $newValue');
    }
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      debugPrint('❌ Provider failed: ${provider.name ?? provider.runtimeType}');
      debugPrint('   Error: $error');
      debugPrint('   Stack trace: $stackTrace');
    }
    super.providerDidFail(provider, error, stackTrace, container);
  }
}