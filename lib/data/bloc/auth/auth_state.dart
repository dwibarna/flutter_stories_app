import 'package:equatable/equatable.dart';

abstract class AuthStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnSplashState extends AuthStates {}

class AfterSplashState extends AuthStates {
  final String token;

  AfterSplashState({required this.token});

  @override
  List<Object?> get props => [token];
}
