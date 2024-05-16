import 'package:equatable/equatable.dart';

abstract class AuthEvents extends Equatable {
  const AuthEvents();

  @override
  List<Object> get props => [];
}

class GetAuthToken extends AuthEvents {
  final String token;

  const GetAuthToken(this.token);

  @override
  List<Object> get props => [token];
}
