import 'package:flutter_stories_app/presentation/pages/add_story_screen.dart';
import 'package:flutter_stories_app/presentation/pages/detail_screen.dart';
import 'package:flutter_stories_app/presentation/pages/home_screen.dart';
import 'package:flutter_stories_app/presentation/pages/login_screen.dart';
import 'package:flutter_stories_app/presentation/pages/pick_location_screen.dart';
import 'package:flutter_stories_app/presentation/pages/register_screen.dart';
import 'package:flutter_stories_app/presentation/pages/splash_screen.dart';
import 'package:flutter_stories_app/route/route_name.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final router = GoRouter(initialLocation: RouteName.init, routes: [
  GoRoute(
      path: '/${RouteName.home}',
      name: RouteName.home,
      routes: [
        GoRoute(
            path: '${RouteName.add}',
            name: RouteName.add,
            routes: [
              GoRoute(
                  path: '${RouteName.location}',
                  name: RouteName.location,
                  builder: (context, state) {
                    final LatLng? latLng = state.extra as LatLng?;
                    return PickLocationScreen(
                      latLng: latLng,
                    );
                  }
              )
            ],
            builder: (context, state) {
              return const AddStoryScreen();
            }),
        GoRoute(
            path: '${RouteName.home}/:id',
            name: RouteName.detail,
            builder: (context, state) {
              return DetailScreen(
                id: state.pathParameters['id'].toString(),
              );
            }),
      ],
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
]);
