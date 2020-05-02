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
      Provider.of<VideosList>(context).fetchChannelVideos(channelIds: [
        'UCBJycsmduvYEL83R_U4JriQ',
        'UCXGgrKt94gR6lmN4aN3mYTg'
      ]).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  _loadMoreVideos() async {
    _isLoading = true;
    await VideosList().fetchChannelVideos(
        channelIds: ['UCBJycsmduvYEL83R_U4JriQ', 'UCXGgrKt94gR6lmN4aN3mYTg']);
    _isLoading = false;
  }

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
              if (scrollDetails.metrics.pixels ==
                  scrollDetails.metrics.maxScrollExtent) {
                _loadMoreVideos();
                // VideosList().fetchChannelVideos(
                //     channelIds: ['UCBJycsmduvYEL83R_U4JriQ', 'UCXGgrKt94gR6lmN4aN3mYTg']);
              }
              return false;
            },
            child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: Key(videos.videosList[index].thumbnailUrl),
                    child: VideoTile(
                        id: "1",
                        title: videos.videosList[index].title,
                        imageUrl: videos.videosList[index].thumbnailUrl,
                        fetch: didChangeDependencies),
                  );
                },
                itemCount: videos.videosList.length),
          );
  }
}
