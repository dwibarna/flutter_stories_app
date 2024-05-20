import 'package:flutter_stories_app/presentation/pages/add_story_screen.dart';
import 'package:flutter_stories_app/presentation/pages/detail_screen.dart';
import 'package:flutter_stories_app/presentation/pages/home_screen.dart';
import 'package:flutter_stories_app/presentation/pages/login_screen.dart';
import 'package:flutter_stories_app/presentation/pages/register_screen.dart';
import 'package:flutter_stories_app/presentation/pages/splash_screen.dart';
import 'package:flutter_stories_app/route/route_name.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: RouteName.init, routes: [
  GoRoute(
      path: '/${RouteName.add}',
      name: RouteName.add,
      builder: (context, state) {
        return const AddStoryScreen();
      }),
  GoRoute(
      path: '/${RouteName.home}',
      name: RouteName.home,
      builder: (context, state) {
        return const HomeScreen();
      }),
  GoRoute(
      path: RouteName.init,
      name: RouteName.splash,
      builder: (context, state) {
        return const SplashScreen();
      }),
  GoRoute(
      path: '/${RouteName.login}',
      name: RouteName.login,
      builder: (context, state) {
        return const LoginScreen();
      }),
  GoRoute(
      path: '/${RouteName.register}',
      name: RouteName.register,
      builder: (context, state) {
        return const RegisterScreen();
      }),
  GoRoute(
      path: '/${RouteName.home}/:id',
      name: RouteName.detail,
      builder: (context, state) {
        return DetailScreen(
          id: state.pathParameters['id'].toString(),
        );
      }),
]);
