import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/api/api_service.dart';
import 'package:flutter_stories_app/data/bloc/home/home_event.dart';
import 'package:flutter_stories_app/data/bloc/home/home_state.dart';
import 'package:flutter_stories_app/data/preference/preference_manager.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final PreferenceManager _preferenceManager;
  final ApiService _apiService;

  HomeBloc(this._preferenceManager, this._apiService) : super(OnLoading()) {
    on<GetStoryListEvent>(_getStoryList);
    on<OnLogOutEvent>(_logOut);
  }

  _getStoryList(GetStoryListEvent event, Emitter<HomeStates> emit) async {
    emit(OnLoading());
    try {
      final token = await _preferenceManager.getLoginUser();

      await _apiService.getListStory(token).then((value) {
        if (!value.error) {
          emit(OnSuccess(response: value.listStory));
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
