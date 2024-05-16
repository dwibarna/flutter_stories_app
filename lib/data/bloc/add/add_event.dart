import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart' show XFile;

abstract class AddEvents extends Equatable {
  const AddEvents();

  @override
  List<Object> get props => [];
}

class SetImageEvent extends AddEvents {
  final String? imagePath;
  final XFile? imageFile;

  const SetImageEvent({required this.imagePath, required this.imageFile});
}

class UploadStoryEvent extends AddEvents {
  final List<int> bytes;
  final String fileName;
  final String description;

  const UploadStoryEvent(
      {required this.bytes, required this.fileName, required this.description});

  @override
  List<Object> get props => [bytes, fileName, description];
}
