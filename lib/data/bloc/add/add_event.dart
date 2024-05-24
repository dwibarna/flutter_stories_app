import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart' show XFile;

abstract class AddEvents extends Equatable {
  const AddEvents();

  @override
  List<Object?> get props => [];
}

class SetImageEvent extends AddEvents {
  final String? imagePath;
  final XFile? imageFile;

  const SetImageEvent({required this.imagePath, required this.imageFile});

  @override
  List<Object?> get props => [imageFile, imagePath];
}

class UpdateDataPaidEvent extends AddEvents {
  final LatLng? latLng;
  final String? imagePath;
  final XFile? imageFile;

  const UpdateDataPaidEvent({required this.latLng, required this.imageFile, required this.imagePath});

  @override
  List<Object?> get props => [latLng, imagePath, imageFile];
}

class UploadStoryEvent extends AddEvents {
  final List<int> bytes;
  final String fileName;
  final String description;
  final LatLng? latLng;

  const UploadStoryEvent(
      {required this.bytes, required this.fileName, required this.description, required this.latLng});

  @override
  List<Object?> get props => [bytes, fileName, description, latLng];
}
