import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/register/register_bloc.dart';
import 'package:flutter_stories_app/data/bloc/register/register_event.dart';
import 'package:flutter_stories_app/data/bloc/register/register_state.dart';
import 'package:flutter_stories_app/presentation/widgets/display_loading.dart';
import 'package:go_router/go_router.dart';

import '../../route/route_name.dart';
import '../widgets/custom_snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterScreen();
  }
}

class _RegisterScreen extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            context.pop();
          },
        ),
        backgroundColor: Colors.green,
      ),
      body:
          BlocConsumer<RegisterBloc, RegisterStates>(builder: (context, state) {
        if (state is OnLoading) {
          return customLoading();
        } else {
          return _buildBodyRegisterScreen(context);
        }
      }, listener: (context, state) {
        if (state is OnSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                customSnackBar(StatusSnackBar.success, state.message));
          context.goNamed(RouteName.login);
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

  SingleChildScrollView _buildBodyRegisterScreen(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 16,
          ),
          Image.asset(
            'assets/images/logo_app.png',
            height: 150,
            alignment: AlignmentDirectional.center,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            'Buat Akun',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
                isDense: true,
                hintText: 'Name',
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
            obscureText: true,
            controller: passwordController,
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
            height: 16,
          ),
          ElevatedButton(
              onPressed: () {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();
                final name = nameController.text.trim();
                final registerBloc = BlocProvider.of<RegisterBloc>(context);

                if (email.isEmpty && password.isEmpty && name.isEmpty) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(customSnackBar(StatusSnackBar.warning,
                        "Isi semua data terlebih dahulu"));
                  return;
                }

                if (name.isEmpty) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(customSnackBar(
                        StatusSnackBar.warning, "Isi nama terlebih dahulu"));
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

                registerBloc.add(PostRegisterEvent(
                    name: name, password: password, email: email));
//                loginBloc.add((password, email));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'Daftar',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
