import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/provider_observer.dart';

void main() {
  // Remove # from web URLs for better web experience
  usePathUrlStrategy();
  
  runApp(
    ProviderScope(
      // Add observer for debugging in development
      observers: const [AppProviderObserver()],
      child: const CreatorPlatformApp(),
    ),
  );
}

class CreatorPlatformApp extends ConsumerWidget {
  const CreatorPlatformApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'Creator Platform Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}