import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/videosList.dart';
import '../widgets/videoTile.dart';
import '../providers/video.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var _isInit = true;
  var _isLoading = false;


  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<VideosList>(context).fetchChannelVideos(channelIds: ['UC6Dy0rQ6zDnQuHQ1EeErGUA']).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  _fetchVideos() async {
    // List<Video> videos =
    await VideosList()
        .fetchChannelVideos(channelIds: ['UC6Dy0rQ6zDnQuHQ1EeErGUA']);
    print("playing video");
  }

  @override
  Widget build(BuildContext context) {
    VideosList videos = Provider.of<VideosList>(context);
    return videos.videosList.length <= 0
        ? Center(
            child: FlatButton.icon(
                onPressed: _fetchVideos,
                icon: Icon(Icons.cloud_download),
                label: Text("Fetch Videos")),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return VideoTile(
                  id: "1",
                  title: "Skoda Octavia",
                  imageUrl:
                      "https://i.ytimg.com/vi/bHDtxj5YDNs/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLCnVjhI-mMTOrZ5qvo_csv5ZRFwag",
                  fetch: _fetchVideos);
            },
            itemCount: videos.videosList.length);
  }
}
