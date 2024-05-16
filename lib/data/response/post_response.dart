import 'dart:convert';

class PostResponse {
  bool error;
  String message;

  PostResponse({
    required this.error,
    required this.message,
  });

  factory PostResponse.fromRawJson(String str) =>
      PostResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
