import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/api/api_service.dart';
import 'package:flutter_stories_app/data/bloc/detail/detail_event.dart';
import 'package:flutter_stories_app/data/bloc/detail/detail_state.dart';
import 'package:flutter_stories_app/data/preference/preference_manager.dart';

class DetailBloc extends Bloc<DetailEvents, DetailStates> {
  final PreferenceManager preferenceManager;
  final ApiService apiService;

  DetailBloc({required this.preferenceManager, required this.apiService})
      : super(OnLoading()) {
    on<GetDetailStoryEvent>(_getDetailStory);
  }

  _getDetailStory(GetDetailStoryEvent event, Emitter<DetailStates> emit) async {
    emit(OnLoading());
    try {
      final token = await preferenceManager.getLoginUser();
      await apiService.getDetailStory(token, event.id).then((value) {
        if (!value.error) {
          emit(OnSuccess(response: value.story));
        } else {
          emit(OnError(error: value.message));
        }
      });
    } catch (e) {
      emit(OnError(error: e.toString()));
    }
  }
}
