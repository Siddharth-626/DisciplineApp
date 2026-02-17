import 'package:discipline_app/features/auth/presentation/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    final isLoading = state.isLoading;

    ref.listen(authControllerProvider, (_, next) {
      next.whenOrNull(error: (error, _) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
      });
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Welcome Back', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 24),
                  TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: isLoading
                        ? null
                        : () => ref
                            .read(authControllerProvider.notifier)
                            .signIn(_email.text.trim(), _password.text.trim()),
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: isLoading ? null : () => context.push('/register'),
                    child: const Text('Create account'),
                  ),
                  OutlinedButton.icon(
                    onPressed: isLoading
                        ? null
                        : () => ref.read(authControllerProvider.notifier).googleSignIn(),
                    icon: const Icon(Icons.login),
                    label: const Text('Continue with Google'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
