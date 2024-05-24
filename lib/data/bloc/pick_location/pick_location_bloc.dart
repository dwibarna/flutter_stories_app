import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/pick_location/pick_location_event.dart';
import 'package:flutter_stories_app/data/bloc/pick_location/pick_location_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class PickLocationBloc extends Bloc<PickLocationEvents, PickLocationStates> {
  PickLocationBloc() : super(InitialState()) {
    on<GetLocationEvent>(_getLocationEvent);
  }

  _getLocationEvent(GetLocationEvent event, Emitter<PickLocationStates> emit) async {
    try {
      final Location location = Location();
      late bool serviceEnabled;
      late PermissionStatus permissionStatus;
      late LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();
        if (permissionStatus != PermissionStatus.denied) {
          return;
        }
      }

      if(event.latLong == null) {
        locationData = await location.getLocation();
        final latLong = LatLng(locationData.latitude!, locationData.longitude!);

        final info = await geo.placemarkFromCoordinates(latLong.latitude, latLong.longitude);
        emit(LocationState(latLng: latLong, placeMark: info[0]));
      } else {
        final info = await geo.placemarkFromCoordinates(event.latLong!.latitude, event.latLong!.longitude);
        emit(LocationState(latLng: event.latLong!, placeMark: info[0]));
      }

    } catch (e) {
      emit(OnErrorState(message: e.toString()));
    }
  }
}
