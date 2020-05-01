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

  // _fetchVideos() async {
  //   // List<Video> videos =
  //     Provider.of<VideosList>(context).fetchChannelVideos(channelIds: ['UC6Dy0rQ6zDnQuHQ1EeErGUA']).then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   print("playing video");
  // }

  @override
  Widget build(BuildContext context) {
    VideosList videos = Provider.of<VideosList>(context);
    return videos.videosList.length <= 0
        ? Center(
            child: FlatButton.icon(
                onPressed: didChangeDependencies,
                icon: Icon(Icons.cloud_download),
                label: Text("Fetch Videos")),
          )
        : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    videos.videosList.length != videos.videosList.length &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                        VideosList().fetchChannelVideos(channelIds: ['UC6Dy0rQ6zDnQuHQ1EeErGUA']);
                }
                return false;
              },
        child: 
        ListView.builder(
            itemBuilder: (ctx, index) {
              return VideoTile(
                  id: "1",
                  title: videos.videosList[index].title,
                  imageUrl:
                      videos.videosList[index].thumbnailUrl,
                  fetch: didChangeDependencies);
            },
            itemCount: videos.videosList.length),
        )
        
        
  }
}
