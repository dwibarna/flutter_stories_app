import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/register/register_event.dart';
import 'package:flutter_stories_app/data/bloc/register/register_state.dart';

import '../../api/api_service.dart';
import '../../preference/preference_manager.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  final PreferenceManager prefs;
  final ApiService apiService;

  RegisterBloc({required this.prefs, required this.apiService})
      : super(Initial()) {
    on<PostRegisterEvent>(_postRegister);
  }

  _postRegister(PostRegisterEvent event, Emitter<RegisterStates> emit) async {
    emit(OnLoading());
    try {
      final response = await apiService.registerUser(
          event.name, event.email, event.password);

      if (!response.error) {
        emit(OnSuccess(message: response.message));
      } else {
        emit(OnError(error: response.message));
      }
    } catch (e) {
      emit(OnError(error: e.toString()));
    }
  }
}
