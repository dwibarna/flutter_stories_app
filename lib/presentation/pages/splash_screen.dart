import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_stories_app/data/bloc/auth/auth_bloc.dart';
import 'package:flutter_stories_app/data/bloc/auth/auth_event.dart';
import 'package:flutter_stories_app/data/bloc/auth/auth_state.dart';
import 'package:flutter_stories_app/data/preference/preference_manager.dart';
import 'package:flutter_stories_app/route/route_name.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    PreferenceManager()
        .getLoginUser()
        .then((value) => authBloc.add(GetAuthToken(value)));
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthStates>(
        builder: (BuildContext _, state) {
          return Container(
            decoration: const BoxDecoration(color: Colors.white70),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_app.png',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const SpinKitWaveSpinner(
                    color: Colors.redAccent,
                    size: 50,
                  )
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {
          if (state is AfterSplashState) {
            if (state.token.isNotEmpty) {
              context.goNamed(RouteName.home);
            } else {
              context.goNamed(RouteName.login);
            }
          }
        },
      ),
    );
  }

  Widget buildScaffold(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white70),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo_app.png',
              ),
              const SizedBox(
                height: 24,
              ),
              const SpinKitWaveSpinner(
                color: Colors.redAccent,
                size: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
