import 'package:equatable/equatable.dart';
import 'package:flutter_stories_app/data/model/story.dart';
import 'package:geocoding/geocoding.dart';

class DetailStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnLoading extends DetailStates {}

class OnSuccess extends DetailStates {
  final Story response;
  final List<Placemark>? info;

  OnSuccess(this.info, {required this.response});

  @override
  List<Object> get props => [response];
}

class OnError extends DetailStates {
  final String error;

  OnError({required this.error});

  @override
  List<Object?> get props => [error];
}
