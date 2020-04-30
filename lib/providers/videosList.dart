import 'package:flutter/material.dart';
import '../models/video.dart';
import 'package:http/http.dart' as http;


class VideosList with ChangeNotifier {
  List<Video> videoList = [];
  VideosList();
}