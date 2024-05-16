import 'package:equatable/equatable.dart';
import 'package:flutter_stories_app/data/model/story.dart';

class HomeStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnLoading extends HomeStates {}

class OnSuccess extends HomeStates {
  final List<Story> response;

  OnSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class OnError extends HomeStates {
  final String error;

  OnError({required this.error});

  @override
  List<Object?> get props => [error];
}

class DoLogOut extends HomeStates {}
