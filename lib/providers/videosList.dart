import 'package:flutter/material.dart';
import '../models/video.dart';
import 'package:http/http.dart' as http;
import '../models/channel.dart';
import 'dart:io';
import 'dart:convert';
import '../keys.dart';

class VideosList with ChangeNotifier {
  List<Video> videoList = [];
  VideosList();

  final String _baseUrl = "www.googleapis.com";
  String _nextPageToken = '';
  Future<List<Video>> fetchChannelVideos({List<String> channelIds}) async {
    List<Video> videos = [];
    channelIds.forEach((id) async {
      Map<String, String> parameters = {
        'part': 'snippet, contentDetails, statistics',
        'id': id,
        'key': api_key
      };

      Uri uri = Uri.https(
        _baseUrl,
        '/youtube/v3/channels',
        parameters,
      );

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };

      // Get Channel
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body)['items'][0];
        Channel channel = Channel.fromMap(data);

        // Fetch first batch of videos from uploads playlist
        channel.videos = await fetchVideosFromPlaylist(
          playlistId: channel.uploadPlaylistId,
        );
        // return channel;
        videos.addAll(channel.videos);
      } else {
        throw json.decode(response.body)['error']['message'];
      }
    });
    return videos;
  }

  Future<List<Video>> fetchVideosFromPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': api_key,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
