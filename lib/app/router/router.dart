import 'package:doit_doit/pages/root_page.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home('/home'),
  signIn('/signIn');

  const AppRoute(this.path);

  final String path;
}

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RootPage(),
    ),
    // GoRoute(
    //   path: AppRoute.home.path,
    //   builder: (context, state) => const HomePage(),
    // ),
    // GoRoute(
    //   path: AppRoute.signIn.path,
    //   builder: (context, state) => const SignInPage(),
    // ),
  ],
);
