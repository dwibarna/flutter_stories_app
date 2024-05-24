import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_stories_app/data/response/detail_story_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client, MultipartFile;

import '../response/list_story_response.dart';
import '../response/login_response.dart';
import '../response/post_response.dart';

class ApiService {
  final Client client;
  ApiService(this.client);

  static const baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<PostResponse> postAddNewStory(
      String desc, List<int> bytes, String fileName, String token, LatLng? latLng) async {
    const String url = '$baseUrl/stories';

    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);

    final Map<String, String> fields = {'description': desc};


    final MultipartFile multipartFile =
        http.MultipartFile.fromBytes('photo', bytes, filename: fileName);

    final Map<String, String> headers = {
      "Content-type": 'multipart/form-data',
      "Authorization": 'Bearer $token'
    };

    if(latLng != null) {
      fields['lat'] = latLng.latitude.toString();
      fields['lon'] = latLng.longitude.toString();
    }

    request.fields.addAll(fields);
    request.files.add(multipartFile);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (streamedResponse.statusCode == 201 ||
        streamedResponse.statusCode == 200) {
      return PostResponse.fromRawJson(responseData);
    } else {
      throw Exception('failed to upload');
    }
  }

  Future<DetailStoryResponse> getDetailStory(String token, String id) async {
    try {
      String url = '$baseUrl/stories/$id';

      final Map<String, String> headers = {'Authorization': 'Bearer $token'};

      final response = await client.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        return DetailStoryResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            DetailStoryResponse.fromJson(json.decode(response.body)).message);
      }
    } on http.ClientException {
      throw Exception('Failed to connect to the internet');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ListStoryResponse> getListStory(String token, int page, int pageSize) async {
    try {
      String url = '$baseUrl/stories?page=$page&size=$pageSize';

      final Map<String, String> headers = {'Authorization': 'Bearer $token'};

      final response = await client.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return ListStoryResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            ListStoryResponse.fromJson(json.decode(response.body)).message);
      }
    } on http.ClientException {
      throw Exception('Failed to connect to the internet');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PostResponse> registerUser(
      String name, String email, String password) async {
    try {
      const String url = '$baseUrl/register';
      final Map<String, dynamic> requestBody = {
        'name': name,
        'email': email,
        'password': password
      };

      final String requestBodyJson = json.encode(requestBody);
      final http.Response response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'}, body: requestBodyJson);

      if (response.statusCode == 201) {
        return PostResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            PostResponse.fromJson(json.decode(response.body)).message);
      }
    } on http.ClientException {
      throw Exception('Failed to Connect Internet');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<LoginResponse> loginUser(String email, String password) async {
    try {
      const String url = '$baseUrl/login';
      final Map<String, dynamic> requestBody = {
        'email': email,
        'password': password
      };
      final String requestBodyJson = json.encode(requestBody);
      final http.Response response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'}, body: requestBodyJson);

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            LoginResponse.fromJson(json.decode(response.body)).message);
      }
    } on http.ClientException {
      throw Exception('Failed to connect to the internet');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
