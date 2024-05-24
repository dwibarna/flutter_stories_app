import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/pick_location/pick_location_bloc.dart';
import 'package:flutter_stories_app/utils/flavor_config.dart';
import 'package:flutter_stories_app/utils/flavor_type.dart';
import 'package:http/http.dart' as http;

import 'data/api/api_service.dart';
import 'data/bloc/add/add_bloc.dart';
import 'data/bloc/auth/auth_bloc.dart';
import 'data/bloc/detail/detail_bloc.dart';
import 'data/bloc/home/home_bloc.dart';
import 'data/bloc/login/login_bloc.dart';
import 'data/bloc/register/register_bloc.dart';
import 'data/preference/preference_manager.dart';
import 'my_app.dart';

void main() {
  final preferenceManager = PreferenceManager();
  final apiService = ApiService(http.Client());
  FlavorConfig(
      flavorType: FlavorType.paid,
      color: Colors.green,
      flavorValues: const FlavorValues(titleApp: 'Story App Premium'));

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
    BlocProvider(create: (context) => AddBloc(apiService, preferenceManager)),
    BlocProvider(create: (context) => PickLocationBloc())
  ], child: const MyApp()));
}
