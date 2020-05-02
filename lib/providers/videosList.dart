import 'package:flutter/material.dart';
import '../providers/video.dart';
import 'package:http/http.dart' as http;
import '../models/channel.dart';
import 'dart:io';
import 'dart:convert';
import '../keys.dart';

class VideosList with ChangeNotifier {
  List<Video> _videoList = [];
  // VideosList();

  List<Video> get videosList {
    return _videoList;
  }

  final String _baseUrl = "www.googleapis.com";
  Map _nextPageToken = {};
  Future<void> fetchChannelVideos({List<String> channelIds}) async {
    // _videoList = [];
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
        _videoList.addAll(channel.videos);
        notifyListeners();
      } else {
        throw json.decode(response.body)['error']['message'];
      }
    });
    // return videos;
  }

  Future<List<Video>> fetchVideosFromPlaylist({String playlistId}) async {
    _nextPageToken[playlistId] = "";
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken[playlistId],
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

      _nextPageToken[playlistId] = data['nextPageToken'] ?? '';
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
