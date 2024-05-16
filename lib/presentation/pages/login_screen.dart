import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/login/login_bloc.dart';
import 'package:flutter_stories_app/data/bloc/login/login_event.dart';
import 'package:flutter_stories_app/data/bloc/login/login_state.dart';
import 'package:flutter_stories_app/presentation/widgets/display_loading.dart';
import 'package:flutter_stories_app/route/route_name.dart';
import 'package:go_router/go_router.dart';

import '../widgets/custom_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginStates>(builder: (context, state) {
        if (state is OnLoading) {
          return customLoading();
        } else {
          return _buildLoginScreen(context);
        }
      }, listener: (context, state) {
        if (state is OnSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                customSnackBar(StatusSnackBar.success, state.message));
          context.goNamed(RouteName.home);
        }

        if (state is OnError) {
          customSnackBar(StatusSnackBar.error, state.error);

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBar(StatusSnackBar.error, state.error));
        }
      }),
    );
  }

  Widget _buildLoginScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/logo_app.png'),
              Text('Masuk',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    isDense: true,
                    hintText: 'Email',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(6)))),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    isDense: true,
                    hintText: 'Password',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(6)))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {
                  context.pushNamed(RouteName.register);
                },
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              ElevatedButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  final loginBloc = BlocProvider.of<LoginBloc>(context);

                  if (email.isEmpty && password.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(customSnackBar(StatusSnackBar.warning,
                          "Isi email dan password terlebih dahulu"));
                    return;
                  }

                  if (email.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(customSnackBar(
                          StatusSnackBar.warning, "Isi email terlebih dahulu"));
                    return;
                  }

                  if (!EmailValidator.validate(email)) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(customSnackBar(StatusSnackBar.warning,
                          "Email yang Anda masukkan tidak sesuai format"));
                    return;
                  }

                  if (password.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(customSnackBar(StatusSnackBar.warning,
                          "Isi password terlebih dahulu"));
                    return;
                  }

                  if (password.length <= 7) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(customSnackBar(StatusSnackBar.warning,
                          "Password harus lebih dari 8 karakter"));
                    return;
                  }

                  loginBloc.add(PostLoginEvent(password, email));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
    );
  }
}
