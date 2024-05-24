import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationStates extends Equatable {

  @override
  List<Object?> get props => [];
}
class InitialState extends PickLocationStates {}

class LocationState extends PickLocationStates {
  final LatLng latLng;
  final geo.Placemark placeMark;

  LocationState({required this.latLng, required this.placeMark});

  @override
  List<Object?> get props => [latLng];
}

class OnErrorState extends PickLocationStates {
  final String message;

  OnErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
