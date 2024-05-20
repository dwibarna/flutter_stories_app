

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

/*
  factory ListStoryResponse.fromJson(Map<String, dynamic> json) =>
      ListStoryResponse(
        error: json["error"],
        message: json["message"],
        listStory:
        List<Story>.from(json["listStory"].map((x) => Story.fromJson(x))),
      );
*/

  Map<String, dynamic> toJson() => _$ListStoryResponseToJson(this);

  factory ListStoryResponse.fromJson(Map<String, dynamic> json) => _$ListStoryResponseFromJson(json);


/*  factory ListStoryResponse.fromRawJson(String str) =>
      ListStoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());*/

/*  factory ListStoryResponse.fromJson(Map<String, dynamic> json) =>
      ListStoryResponse(
        error: json["error"],
        message: json["message"],
        listStory:
            List<Story>.from(json["listStory"].map((x) => Story.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "listStory": List<dynamic>.from(listStory.map((x) => x.toJson())),
      };*/
}
