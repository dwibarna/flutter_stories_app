import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/api/api_service.dart';
import 'package:flutter_stories_app/data/bloc/home/home_event.dart';
import 'package:flutter_stories_app/data/bloc/home/home_state.dart';
import 'package:flutter_stories_app/data/preference/preference_manager.dart';

import '../../model/story.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final PreferenceManager _preferenceManager;
  final ApiService _apiService;
  int pageSize = 10;
  int? page = 1;
  List<Story> story = [];

  HomeBloc(this._preferenceManager, this._apiService) : super(OnLoading()) {
    on<GetStoryListEvent>(_getStoryList);
    on<OnLogOutEvent>(_logOut);
  }

  _getStoryList(GetStoryListEvent event, Emitter<HomeStates> emit) async {
    try {
      final token = await _preferenceManager.getLoginUser();
      if (page == 1) {
        emit(OnLoading());
      }
      await _apiService.getListStory(token, page!, pageSize).then((value) {
        if (!value.error) {
          if (value.listStory.length < pageSize) {
            page = null;
          } else {
            emit(OnSuccess(response: value.listStory));
            page = page! + 1;
          }
        } else {
          emit(OnError(error: value.message));
        }
      });
    } catch (e) {
      emit(OnError(error: e.toString()));
    }
  }

  _logOut(OnLogOutEvent event, Emitter<HomeStates> emit) {
    emit(OnLoading());
    try {
      _preferenceManager.logOutUser();
      emit(DoLogOut());
    } catch (e) {
      emit(OnError(error: e.toString()));
    }
  }
}
