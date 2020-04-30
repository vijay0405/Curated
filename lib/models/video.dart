class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;

  Video({this.channelTitle, this.id, this.thumbnailUrl, this.title});

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
        channelTitle: snippet['channelTitle'],
        id: snippet['resourceId']['videoId'],
        thumbnailUrl: snippet['thumbnails']['high']['url'],
        title: snippet['title']);
  }
}
