import 'package:equatable/equatable.dart';

class LoginEvents extends Equatable {
  const LoginEvents();

  @override
  List<Object?> get props => [];
}

class PostLoginEvent extends LoginEvents {
  final String email;
  final String password;

  const PostLoginEvent(this.password, this.email);

  @override
  List<Object?> get props => [email, password];
}
