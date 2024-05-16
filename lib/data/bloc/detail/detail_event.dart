import 'package:equatable/equatable.dart';

class DetailEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDetailStoryEvent extends DetailEvents {
  final String id;

  GetDetailStoryEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
