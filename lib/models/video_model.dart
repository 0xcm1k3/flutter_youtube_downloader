class Video {
  String origin;
  String title;
  String thumbnailUrl;
  List<Map<String, String>> mp3Urls;
  List<Map<String, String>> mp4Urls;
  Video({
    required this.origin,
    required this.title,
    required this.thumbnailUrl,
    required this.mp3Urls,
    required this.mp4Urls,
  });
}
