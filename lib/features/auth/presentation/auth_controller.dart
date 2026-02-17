import 'package:discipline_app/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>(
  (ref) => AuthController(ref),
);

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController(this._ref) : super(const AsyncData(null));

  final Ref _ref;

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _ref.read(authServiceProvider).signInWithEmail(email: email, password: password),
    );
  }

  Future<void> register(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _ref.read(authServiceProvider).registerWithEmail(email: email, password: password),
    );
  }

  Future<void> googleSignIn() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _ref.read(authServiceProvider).signInWithGoogle());
  }

  Future<void> signOut() async {
    await _ref.read(authServiceProvider).signOut();
  }
}
