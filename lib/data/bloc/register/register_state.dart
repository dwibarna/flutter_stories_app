import 'package:equatable/equatable.dart';

class RegisterStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends RegisterStates {}

class OnLoading extends RegisterStates {}

class OnSuccess extends RegisterStates {
  final String message;

  OnSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class OnError extends RegisterStates {
  final String error;

  OnError({required this.error});

  @override
  List<Object?> get props => [error];
}
