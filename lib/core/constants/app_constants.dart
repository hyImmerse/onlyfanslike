class AppConstants {
  // App Info
  static const String appName = 'Creator Platform';
  static const String appVersion = '1.0.0';
  
  // API Endpoints (for demo, we'll use mock data)
  static const String baseUrl = 'https://api.creatorplatform.com';
  static const String apiVersion = '/v1';
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String themeKey = 'theme_mode';
  static const String onboardingKey = 'onboarding_completed';
  
  // Pagination
  static const int pageSize = 20;
  
  // Demo Mode
  static const bool isDemoMode = true;
  static const String demoEmail = 'demo@creatorplatform.com';
  static const String demoPassword = 'demo1234';
  
  // Content Security
  static const bool enableContentProtection = true;
  static const bool showWatermark = true;
}