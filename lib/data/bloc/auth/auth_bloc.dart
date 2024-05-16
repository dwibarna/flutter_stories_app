import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/auth/auth_event.dart';
import 'package:flutter_stories_app/data/bloc/auth/auth_state.dart';
import 'package:flutter_stories_app/data/preference/preference_manager.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final PreferenceManager preferenceManager;

  AuthBloc(this.preferenceManager) : super(OnSplashState()) {
    on<GetAuthToken>(_getAuthToken);
  }

  _getAuthToken(GetAuthToken event, Emitter<AuthStates> emit) async {
    emit(OnSplashState());
    await Future.delayed(const Duration(seconds: 3));
    emit(AfterSplashState(token: event.token));
  }
}
