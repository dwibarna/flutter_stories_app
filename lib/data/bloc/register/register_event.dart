import 'package:equatable/equatable.dart';

class RegisterEvents extends Equatable {
  const RegisterEvents();

  @override
  List<Object?> get props => [];
}

class PostRegisterEvent extends RegisterEvents {
  final String name;
  final String password;
  final String email;

  const PostRegisterEvent(
      {required this.name, required this.password, required this.email});

  @override
  List<Object> get props => [name, password, email];
}
