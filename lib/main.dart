import 'package:discipline_app/core/constants/app_constants.dart';
import 'package:discipline_app/core/providers.dart';
import 'package:discipline_app/core/theme/app_theme.dart';
import 'package:discipline_app/features/auth/presentation/login_screen.dart';
import 'package:discipline_app/features/auth/presentation/register_screen.dart';
import 'package:discipline_app/features/dashboard/presentation/dashboard_screen.dart';
import 'package:discipline_app/features/tasks/presentation/tasks_screen.dart';
import 'package:discipline_app/services/firebase_initializer.dart';
import 'package:discipline_app/widgets/state_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer.initialize();

  final container = ProviderContainer();
  await container.read(firestoreServiceProvider).enablePersistence();
  await container.read(notificationServiceProvider).initialize();

  runApp(UncontrolledProviderScope(container: container, child: const DisciplineApp()));
}

class DisciplineApp extends ConsumerWidget {
  const DisciplineApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authStateProvider);

    final router = GoRouter(
      initialLocation: '/tasks',
      redirect: (_, state) {
        final user = authAsync.value;
        final authRoutes = state.matchedLocation == '/login' || state.matchedLocation == '/register';
        if (user == null && !authRoutes) return '/login';
        if (user != null && authRoutes) return '/tasks';
        return null;
      },
      routes: [
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
        GoRoute(path: '/tasks', builder: (_, __) => const TasksScreen()),
        GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
      ],
    );

    return MaterialApp.router(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      builder: (context, child) {
        if (authAsync.isLoading) return const AppLoading();
        if (authAsync.hasError) return AppError(message: authAsync.error.toString());
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: child,
        );
      },
    );
  }
}
