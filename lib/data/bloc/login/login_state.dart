import 'package:equatable/equatable.dart';

class LoginStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends LoginStates {}

class OnLoading extends LoginStates {}

class OnSuccess extends LoginStates {
  final String message;

  OnSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class OnError extends LoginStates {
  final String error;

  OnError({required this.error});

  @override
  List<Object?> get props => [error];
}
