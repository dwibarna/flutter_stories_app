import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class CustomMapView extends StatefulWidget {
  final double lat;
  final double long;
  final List<Placemark> infoPlaceMark;

  const CustomMapView({super.key, required this.lat, required this.long, required this.infoPlaceMark});

  @override
  State<CustomMapView> createState() => _CustomMapViewState();
}

class _CustomMapViewState extends State<CustomMapView> {
  late LatLng locateCoordinate;
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  late Placemark place;
  late String address;


  @override
  void initState() {
    place = widget.infoPlaceMark[0];
    address = '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    locateCoordinate = LatLng(widget.lat, widget.long);
    markers.add(
        Marker(
        markerId: const MarkerId('Story'),
        position: locateCoordinate,
        infoWindow: InfoWindow(
          snippet: address,
          title: place.street
        ),
        onTap: () {
          mapController.animateCamera(
              CameraUpdate.newLatLngZoom(
                  locateCoordinate, 18
              )
          );
        })
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(zoom: 18, target: locateCoordinate),
          markers: markers,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          onMapCreated: (controller) {
            mapController = controller;
          },
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            children: [
              FloatingActionButton.small(
                child: const Icon(Icons.my_location),
                  onPressed: () {
                  onMyLocationPressed(LatLng(widget.lat, widget.long));
              }),
              FloatingActionButton.small(
                onPressed: () {
                  mapController.animateCamera(CameraUpdate.zoomIn());
                },
                child: const Icon(Icons.add),
              ),
              FloatingActionButton.small(
                onPressed: () {
                  mapController.animateCamera(CameraUpdate.zoomOut());
                },
                child: Icon(Icons.remove),
              )
            ],
          ),
        )
      ],
    );
  }

  void onMyLocationPressed(LatLng latLng) async {
/*    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionStatus;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if(!serviceEnabled) {
        return;
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if(permissionStatus != PermissionStatus.granted) {
        if (permissionStatus != PermissionStatus.granted) {
          return;
        }
      }
    }*/

/*    locationData = await location.getLocation();
    final latLong = LatLng(locationData.latitude!, locationData.longitude!);*/

    defineMarker(latLng);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng)
    );
  }

  void defineMarker(LatLng latLong) {
    final marker = Marker(
        markerId: MarkerId("story"),
      position: latLong
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }
}
