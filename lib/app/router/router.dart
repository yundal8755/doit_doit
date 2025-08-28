import 'package:doit_doit/presentation/page/root/root_page.dart';
import 'package:doit_doit/presentation/page/sign_in/sign_in_page.dart';
import 'package:doit_doit/presentation/page/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  // home('/home'),
  signIn('/signIn'),
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
    // GoRoute(
    //   path: AppRoute.home.path,
    //   builder: (context, state) => const HomePage(),
    // ),
    GoRoute(
      path: AppRoute.signIn.path,
      builder: (context, state) => const SignInPage(),
    ),
  ],
);
