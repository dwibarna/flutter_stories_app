import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationEvents extends Equatable {

  @override
  List<Object?> get props => [];
}

class GetLocationEvent extends PickLocationEvents {
  final LatLng? latLong;

  GetLocationEvent({required this.latLong});

  @override
  List<Object?> get props => [latLong];
}