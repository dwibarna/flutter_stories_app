import 'package:equatable/equatable.dart';

class HomeEvents extends Equatable {
  const HomeEvents();

  @override
  List<Object?> get props => [];
}

class GetStoryListEvent extends HomeEvents {
  const GetStoryListEvent();

  @override
  List<Object?> get props => [];
}

class OnLogOutEvent extends HomeEvents {}
