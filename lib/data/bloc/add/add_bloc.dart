import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/add/add_event.dart';
import 'package:flutter_stories_app/data/bloc/add/add_state.dart';
import 'package:image/image.dart' as img;

import '../../api/api_service.dart';
import '../../preference/preference_manager.dart';

class AddBloc extends Bloc<AddEvents, AddStates> {
  final ApiService apiService;
  final PreferenceManager preferenceManager;

  AddBloc(this.apiService, this.preferenceManager) : super(InitialState()) {
    on<SetImageEvent>(_getImage);
    on<UploadStoryEvent>(_uploadStoryEvent);
    on<UpdateDataPaidEvent>(_getPaidDataEvent);
  }

  _getImage(SetImageEvent event, Emitter<AddStates> emit) async {
    emit(GetImageState(imagePath: event.imagePath, imageFile: event.imageFile));
  }

  _getPaidDataEvent(UpdateDataPaidEvent event, Emitter<AddStates> emit) async {
    emit(UpdateDataPaidState(
        imagePath: event.imagePath,
        imageFile: event.imageFile,
        latLng: event.latLng));
  }

  _uploadStoryEvent(UploadStoryEvent event, Emitter<AddStates> emit) async {
    emit(OnLoading());
    try {
      final token = await preferenceManager.getLoginUser();
      final newBytes = await _compressImage(event.bytes);
      await apiService
          .postAddNewStory(
              event.description, newBytes, event.fileName, token, event.latLng)
          .then((value) {
        if (!value.error) {
          emit(AfterUploadState(message: value.message));
        } else {
          emit(OnErrorUpload(error: value.message));
        }
      });
    } catch (e) {
      emit(OnErrorUpload(error: e.toString()));
    }
  }

  Future<List<int>> _compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }
}
