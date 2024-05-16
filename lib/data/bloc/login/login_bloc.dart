import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/login/login_event.dart';
import 'package:flutter_stories_app/data/bloc/login/login_state.dart';
import 'package:flutter_stories_app/data/preference/preference_manager.dart';

import '../../api/api_service.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final PreferenceManager prefs;
  final ApiService apiService;

  LoginBloc(this.prefs, this.apiService) : super(Initial()) {
    on<PostLoginEvent>(_postLogin);
  }

  _postLogin(PostLoginEvent event, Emitter<LoginStates> emit) async {
    emit(OnLoading());
    try {
      final response = await apiService.loginUser(event.email, event.password);
      if (!response.error) {
        prefs.setLoginUser(response.loginResult.token);
        emit(OnSuccess(message: response.message));
      } else {
        emit(OnError(error: response.message));
      }
    } catch (e) {
      emit(OnError(error: e.toString()));
    }
  }
}
