import 'package:curated/providers/videosList.dart';
import 'package:curated/widgets/videoTile.dart';
import 'package:flutter/material.dart';
import '../models/video.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  _fetchVideos() async {
    List<Video> videos =
        await VideosList().fetchChannelVideos(channelIds: ['UC6Dy0rQ6zDnQuHQ1EeErGUA']);
    print(videos);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (ctx, index) {
          return VideoTile(
              id: "1",
              title: "Skoda Octavia",
              imageUrl:
                  "https://i.ytimg.com/vi/bHDtxj5YDNs/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLCnVjhI-mMTOrZ5qvo_csv5ZRFwag",
              fetch: _fetchVideos);
        },
        itemCount: 5);
  }
}
