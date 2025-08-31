import 'package:doit_doit/presentation/page/auth/sign_up_page.dart';
import 'package:doit_doit/presentation/page/profile/profile_page.dart';
import 'package:doit_doit/presentation/page/root/root_page.dart';
import 'package:doit_doit/presentation/page/auth/sign_in_page.dart';
import 'package:doit_doit/presentation/page/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  profile('/profile'),
  signIn('/signIn'),
  signUp('/signUp'),
  root('/root');

  const AppRoute(this.path);

  final String path;
}

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoute.root.path,
      builder: (context, state) => const RootPage(),
    ),
    GoRoute(
      path: AppRoute.profile.path,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: AppRoute.signIn.path,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: AppRoute.signUp.path,
      builder: (context, state) => const SignUpPage(),
    ),
  ],
);
