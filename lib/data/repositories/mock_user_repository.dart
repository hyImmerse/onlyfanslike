import 'package:creator_platform_demo/domain/entities/user.dart';
import 'package:creator_platform_demo/domain/repositories/user_repository.dart';
import 'package:creator_platform_demo/data/models/user_model.dart';

class MockUserRepository implements UserRepository {
  User? _currentUser;
  
  static final List<UserModel> _mockUsers = [
    UserModel(
      id: '1',
      email: 'john@example.com',
      name: 'John Doe',
      profileImageUrl: 'https://example.com/profiles/john.jpg',
      isCreator: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      id: '2',
      email: 'jane@example.com',
      name: 'Jane Smith',
      profileImageUrl: 'https://example.com/profiles/jane.jpg',
      isCreator: false,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      id: '3',
      email: 'creator@example.com',
      name: 'Content Creator',
      profileImageUrl: 'https://example.com/profiles/creator.jpg',
      isCreator: true,
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _currentUser;
  }

  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    final userModel = _mockUsers.where((user) => user.email == email).firstOrNull;
    
    if (userModel == null) {
      throw Exception('User not found');
    }
    
    // Simple password validation (in real app, use proper authentication)
    if (password.length < 6) {
      throw Exception('Invalid password');
    }
    
    _currentUser = userModel.toEntity();
    return _currentUser!;
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String name,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    
    // Check if user already exists
    final existingUser = _mockUsers.where((user) => user.email == email).firstOrNull;
    if (existingUser != null) {
      throw Exception('User already exists');
    }
    
    // Validate input
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }
    
    if (name.trim().isEmpty) {
      throw Exception('Name is required');
    }
    
    // Create new user
    final newUserModel = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      profileImageUrl: null,
      isCreator: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    _mockUsers.add(newUserModel);
    _currentUser = newUserModel.toEntity();
    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  @override
  Future<User> updateProfile(User user) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    if (_currentUser == null) {
      throw Exception('No user logged in');
    }
    
    // Find and update the user in mock data
    final index = _mockUsers.indexWhere((u) => u.id == user.id);
    if (index == -1) {
      throw Exception('User not found');
    }
    
    final updatedUserModel = UserModel.fromEntity(user).copyWith(
      updatedAt: DateTime.now(),
    );
    
    _mockUsers[index] = updatedUserModel;
    _currentUser = updatedUserModel.toEntity();
    
    return _currentUser!;
  }

  @override
  Future<bool> isLoggedIn() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _currentUser != null;
  }
}