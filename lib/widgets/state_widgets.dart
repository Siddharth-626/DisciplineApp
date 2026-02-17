import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class AppError extends StatelessWidget {
  const AppError({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}

class AppEmpty extends StatelessWidget {
  const AppEmpty({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
