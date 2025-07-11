import 'package:currency_exchange_app/feature/currency_trade/presentation/providers/auth_controller.dart';
import 'package:currency_exchange_app/feature/currency_trade/presentation/screens/auth/login.dart';
import 'package:currency_exchange_app/feature/currency_trade/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const DashboardScreen(); 
        } else {
          return const LoginScreen(); 
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text("Error: $error")),
      ),
    );
  }
}
