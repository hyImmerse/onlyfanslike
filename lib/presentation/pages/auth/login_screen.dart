import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:creator_platform_demo/presentation/providers/auth_provider.dart';
import 'package:creator_platform_demo/presentation/providers/auth_state_notifier.dart';
import 'package:creator_platform_demo/core/utils/validators.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'john@example.com');
  final _passwordController = TextEditingController(text: 'password123');
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    await ref.read(authStateNotifierProvider.notifier).login(
      email: email,
      password: password,
    );
  }

  void _handleSocialLogin(String provider) async {
    // 데모용 SNS 로그인 시뮬레이션
    await ref.read(authStateNotifierProvider.notifier).loginWithSocialProvider(provider);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);
    final isLoading = authState.isLoading;
    final errorMessage = authState.errorMessage;

    // Navigate to home on successful login
    ref.listen<AuthState>(authStateNotifierProvider, (previous, next) {
      if (next.isAuthenticated) {
        context.go('/home');
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo and Title
                    Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.play_circle_filled,
                            size: 48,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Creator Platform',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '크리에이터와 팬을 연결하는 플랫폼',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),

                    // Login Form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: Validators.email,
                            decoration: const InputDecoration(
                              labelText: '이메일',
                              hintText: 'example@email.com',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            textInputAction: TextInputAction.done,
                            validator: (value) => Validators.minLength(value, 6, fieldName: '비밀번호'),
                            onFieldSubmitted: (_) => _handleLogin(),
                            decoration: InputDecoration(
                              labelText: '비밀번호',
                              hintText: '비밀번호를 입력하세요',
                              prefixIcon: const Icon(Icons.lock_outlined),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Demo Account Info
                          InkWell(
                            onTap: () {
                              // 데모 계정 정보로 자동 채우기
                              _emailController.text = 'john@example.com';
                              _passwordController.text = 'password123';
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Card(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          size: 16,
                                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '데모 계정으로 로그인',
                                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '데모 계정 정보가 자동으로 입력되어 있습니다',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Error Message
                          if (errorMessage != null) ...[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.errorContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Theme.of(context).colorScheme.error,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      errorMessage,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.onErrorContainer,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],

                          // Login Button
                          FilledButton(
                            onPressed: isLoading ? null : _handleLogin,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      '로그인',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Divider
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  '또는',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // SNS Login Section
                          _buildSocialLoginSection(context, isLoading),
                          const SizedBox(height: 16),

                          // Sign Up Button
                          OutlinedButton(
                            onPressed: isLoading ? null : () {
                              context.push('/auth/signup');
                            },
                            child: const Text(
                              '회원가입',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Footer
                    Text(
                      '개발자 데모용 앱입니다',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginSection(BuildContext context, bool isLoading) {
    return Column(
      children: [
        // Google Login Button
        _buildSocialLoginButton(
          context: context,
          provider: 'Google',
          icon: Icons.g_mobiledata,
          backgroundColor: Colors.white,
          textColor: Colors.black87,
          borderColor: Colors.grey.shade300,
          isLoading: isLoading,
        ),
        const SizedBox(height: 12),
        
        // Facebook Login Button
        _buildSocialLoginButton(
          context: context,
          provider: 'Facebook',
          icon: Icons.facebook,
          backgroundColor: const Color(0xFF1877F2),
          textColor: Colors.white,
          borderColor: const Color(0xFF1877F2),
          isLoading: isLoading,
        ),
      ],
    );
  }

  Widget _buildSocialLoginButton({
    required BuildContext context,
    required String provider,
    required IconData icon,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
    required bool isLoading,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : () => _handleSocialLogin(provider),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: Icon(icon, size: 20),
        label: Text(
          '$provider로 로그인',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}