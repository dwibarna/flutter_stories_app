import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart' show XFile;

abstract class AddStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends AddStates {}

class OnLoading extends AddStates {}

class GetImageState extends AddStates {
  final String? imagePath;
  final XFile? imageFile;

  GetImageState({required this.imagePath, required this.imageFile});

  @override
  List<Object?> get props => [imageFile, imagePath];
}

class AfterUploadState extends AddStates {
  final String message;

  AfterUploadState({required this.message});

  @override
  List<Object?> get props => [message];
}

class OnErrorUpload extends AddStates {
  final String error;

  OnErrorUpload({required this.error});

  @override
  List<Object?> get props => [error];
}
