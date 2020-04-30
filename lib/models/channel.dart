import 'video.dart';

class Channel {
  final String id;
  final String title;
  final String profilePicUrl;
  final String subscriberCount;
  final String videoCount;
  final String uploadPlaylistId;
  List<Video> videos;

  Channel(
      {this.id,
      this.profilePicUrl,
      this.subscriberCount,
      this.title,
      this.uploadPlaylistId,
      this.videoCount,
      this.videos});

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
        id: map['id'],
        profilePicUrl: map['snippet']['thumbnails']['default']['url'],
        subscriberCount: map['statistics']['subscriberCount'],
        title: map['snippet']['title'],
        uploadPlaylistId: map['contentDetails']['relatedPlaylists']['uploads'],
        videoCount: map['statistics']['videoCount']);
  }
}
