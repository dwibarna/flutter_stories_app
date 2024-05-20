import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../model/story.dart';
part 'detail_story_response.g.dart';

@JsonSerializable()
class DetailStoryResponse {
  bool error;
  String message;
  Story story;

  DetailStoryResponse({
    required this.error,
    required this.message,
    required this.story,
  });

  factory DetailStoryResponse.fromJson(Map<String, dynamic> json) => _$DetailStoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailStoryResponseToJson(this);

/*  factory DetailStoryResponse.fromRawJson(String str) =>
      DetailStoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());*/

/*  factory DetailStoryResponse.fromJson(Map<String, dynamic> json) =>
      DetailStoryResponse(
        error: json["error"],
        message: json["message"],
        story: Story.fromJson(json["story"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "story": story.toJson(),
      };*/
}
