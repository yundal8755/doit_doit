import 'package:doit_doit/app/enum/social_login_platform.dart';
import 'package:doit_doit/feature/todo/model/todo_model.dart';
import 'package:doit_doit/presentation/page/auth/sign_up_page.dart';
import 'package:doit_doit/presentation/page/home/create_todo_page.dart';
import 'package:doit_doit/presentation/page/home/update_todo_page.dart';
import 'package:doit_doit/presentation/page/profile/profile_page.dart';
import 'package:doit_doit/presentation/page/root/root_page.dart';
import 'package:doit_doit/presentation/page/auth/sign_in_page.dart';
import 'package:doit_doit/presentation/page/splash/splash_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

// ✅ 루트 네비게이터 키 (전역)
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  profile('/profile'),
  signIn('/signIn'),
  signUp('/signUp'),
  root('/root'),
  create('/create'),
  edit('/edit');

  const AppRoute(this.path);

  final String path;
}

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
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
        builder: (context, state) {
          final platform = state.extra as SocialLoginPlatform;
          return SignUpPage(platform: platform);
        }),
    GoRoute(
      path: AppRoute.create.path,
      builder: (context, state) => const CreateTodoPage(),
    ),
    GoRoute(
        path: AppRoute.edit.path,
        builder: (context, state) {
          final todoModel = state.extra as TodoModel;
          return UpdateTodoPage(todoModel: todoModel);
        }),
  ],
);
