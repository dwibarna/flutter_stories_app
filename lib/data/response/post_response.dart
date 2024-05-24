import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  bool error;
  String message;

  PostResponse({
    required this.error,
    required this.message,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);

  factory PostResponse.fromRawJson(String str) =>
      PostResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

/*  factory PostResponse.fromRawJson(String str) =>
      PostResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());*/

/*  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };*/
}
