import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/api/api_service.dart';
import 'package:flutter_stories_app/data/bloc/add/add_bloc.dart';
import 'package:flutter_stories_app/data/bloc/auth/auth_bloc.dart';
import 'package:flutter_stories_app/data/bloc/detail/detail_bloc.dart';
import 'package:flutter_stories_app/data/bloc/home/home_bloc.dart';
import 'package:flutter_stories_app/data/bloc/login/login_bloc.dart';
import 'package:flutter_stories_app/data/bloc/register/register_bloc.dart';
import 'package:flutter_stories_app/data/preference/preference_manager.dart';
import 'package:flutter_stories_app/route/router.dart';
import 'package:http/http.dart' as http;

void main() {
  final preferenceManager = PreferenceManager();
  final apiService = ApiService(http.Client());
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthBloc(preferenceManager),
    ),
    BlocProvider(create: (context) => LoginBloc(preferenceManager, apiService)),
    BlocProvider(
        create: (context) =>
            RegisterBloc(prefs: preferenceManager, apiService: apiService)),
    BlocProvider(create: (context) => HomeBloc(preferenceManager, apiService)),
    BlocProvider(
        create: (context) => DetailBloc(
            preferenceManager: preferenceManager, apiService: apiService)),
    BlocProvider(
        create: (context) => AddBloc(apiService, preferenceManager)
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
