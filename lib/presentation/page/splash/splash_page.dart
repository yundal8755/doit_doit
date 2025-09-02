// lib/features/auth/view/splash_screen.dart
import 'package:doit_doit/app/enum/auth_status.dart';
import 'package:doit_doit/presentation/page/root/root_page.dart';
import 'package:doit_doit/presentation/page/auth/sign_in_page.dart';
import 'package:doit_doit/presentation/page/auth/sign_up_page.dart';
import 'package:doit_doit/presentation/provider/auth/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (status) {
        switch (status) {
          case AuthStatus.signedOut:
            return const SignInPage();
          case AuthStatus.signedInButNotRegistered:
            return const SignUpPage();
          case AuthStatus.signedInAndRegistered:
            return const RootPage();
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(
          child: Text(
            "오류 발생: $error",
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
