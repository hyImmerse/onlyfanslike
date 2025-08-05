import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creator_platform_demo/domain/entities/user.dart';
import 'package:creator_platform_demo/domain/repositories/user_repository.dart';

/// Authentication state enum
enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

/// Authentication state class
class AuthState {
  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // Helper getters
  bool get isLoading => status == AuthStatus.loading;
  bool get isAuthenticated => status == AuthStatus.authenticated && user != null;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  bool get hasError => status == AuthStatus.error && errorMessage != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState &&
        other.status == status &&
        other.user == user &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => Object.hash(status, user, errorMessage);

  @override
  String toString() => 'AuthState(status: $status, user: $user, errorMessage: $errorMessage)';
}

/// Authentication StateNotifier
class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this._userRepository) : super(const AuthState(status: AuthStatus.initial)) {
    _checkInitialAuthStatus();
  }

  final UserRepository _userRepository;

  /// Check initial authentication status
  Future<void> _checkInitialAuthStatus() async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      
      final isLoggedIn = await _userRepository.isLoggedIn();
      
      if (isLoggedIn) {
        final currentUser = await _userRepository.getCurrentUser();
        if (currentUser != null) {
          state = AuthState(
            status: AuthStatus.authenticated,
            user: currentUser,
          );
        } else {
          state = const AuthState(status: AuthStatus.unauthenticated);
        }
      } else {
        state = const AuthState(status: AuthStatus.unauthenticated);
      }
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: 'Failed to check authentication status: ${e.toString()}',
      );
    }
  }

  /// Login with email and password
  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (state.isLoading) return;

    try {
      state = state.copyWith(
        status: AuthStatus.loading,
        errorMessage: null,
      );

      final user = await _userRepository.login(email, password);
      
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  /// Register new user
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    if (state.isLoading) return;

    try {
      state = state.copyWith(
        status: AuthStatus.loading,
        errorMessage: null,
      );

      final user = await _userRepository.register(
        email: email,
        password: password,
        name: name,
      );
      
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  /// Signup new user (alias for register with creator support)
  Future<void> signup({
    required String email,
    required String password,
    required String name,
    bool isCreator = false,
  }) async {
    // TODO: In a real implementation, handle isCreator flag
    // For now, we'll use the existing register method
    await register(
      email: email,
      password: password,
      name: name,
    );
  }

  /// Login with social provider (demo simulation)
  Future<void> loginWithSocialProvider(String provider) async {
    if (state.isLoading) return;

    try {
      state = state.copyWith(
        status: AuthStatus.loading,
        errorMessage: null,
      );

      // 데모용 시뮬레이션: 2초 후 성공
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock user for social login
      final socialUser = User(
        id: 'social_${provider.toLowerCase()}_user',
        email: '${provider.toLowerCase()}@example.com',
        name: '$provider 사용자',
        isCreator: false,
        profileImageUrl: null,
        createdAt: DateTime.now(),
      );
      
      state = AuthState(
        status: AuthStatus.authenticated,
        user: socialUser,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: '$provider 로그인에 실패했습니다: ${e.toString()}',
      );
    }
  }

  /// Logout current user
  Future<void> logout() async {
    if (state.isLoading) return;

    try {
      state = state.copyWith(status: AuthStatus.loading);
      
      await _userRepository.logout();
      
      state = const AuthState(status: AuthStatus.unauthenticated);
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: 'Failed to logout: ${e.toString()}',
      );
    }
  }

  /// Update user profile
  Future<void> updateProfile(User updatedUser) async {
    if (state.isLoading || !state.isAuthenticated) return;

    try {
      state = state.copyWith(status: AuthStatus.loading);
      
      final user = await _userRepository.updateProfile(updatedUser);
      
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: 'Failed to update profile: ${e.toString()}',
      );
    }
  }

  /// Clear error state
  void clearError() {
    if (state.hasError) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: null,
      );
    }
  }

  /// Refresh current user data
  Future<void> refreshUser() async {
    if (!state.isAuthenticated) return;

    try {
      final currentUser = await _userRepository.getCurrentUser();
      if (currentUser != null) {
        state = state.copyWith(user: currentUser);
      }
    } catch (e) {
      // Silently handle refresh errors to avoid disrupting UX
      // Could be logged for debugging purposes
    }
  }
}