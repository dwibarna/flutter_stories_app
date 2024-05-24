import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/pick_location/pick_location_bloc.dart';
import 'package:flutter_stories_app/data/bloc/pick_location/pick_location_event.dart';
import 'package:flutter_stories_app/data/bloc/pick_location/pick_location_state.dart';
import 'package:flutter_stories_app/presentation/widgets/custom_error_screen.dart';
import 'package:flutter_stories_app/presentation/widgets/custom_place_mark.dart';
import 'package:flutter_stories_app/presentation/widgets/display_loading.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationScreen extends StatefulWidget {
  final LatLng? latLng;

  const PickLocationScreen({super.key, this.latLng});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  late final Set<Marker> markers = {};
  late PickLocationBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<PickLocationBloc>(context);
    bloc.add(GetLocationEvent(latLong: widget.latLng));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<PickLocationBloc, PickLocationStates>(
          builder: (BuildContext context, PickLocationStates state) {
            switch (state) {
              case InitialState():
                {
                  return customLoading();
                }
              case LocationState():
                {
                  markers.clear();
                  final marker = Marker(
                      markerId: const MarkerId('story'),
                      position: state.latLng);
                  markers.add(marker);
                  return buildStack(state.latLng, state.placeMark);
                }
              case OnErrorState():
                {
                  return CustomError(onRefresh: () {
                    bloc.add(GetLocationEvent(latLong: widget.latLng));
                  });
                }
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }

  Widget buildStack(LatLng latLng, geo.Placemark placeMark) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
              zoom: 18, target: LatLng(latLng.latitude, latLng.longitude)),
          markers: markers,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          myLocationButtonEnabled: true,
          onLongPress: (latLong) {
            bloc.add(GetLocationEvent(latLong: latLong));
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          left: 16,
          child: Column(
            children: [
              CustomPlaceMark(
                placeMark: placeMark,
                onSavePressed: () {
                  context.pop(latLng);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

