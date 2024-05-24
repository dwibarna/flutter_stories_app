import 'package:json_annotation/json_annotation.dart';

import '../model/story.dart';

part 'list_story_response.g.dart';

@JsonSerializable()
class ListStoryResponse {
  bool error;
  String message;
  List<Story> listStory;

  ListStoryResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  Map<String, dynamic> toJson() => _$ListStoryResponseToJson(this);

  factory ListStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ListStoryResponseFromJson(json);
}
