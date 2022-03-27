// ignore_for_file: file_names

import 'dart:convert';

class SearchResult {
  String videoID;
  String title;
  String desc;
  String pubDate;
  String thumbnail;
  SearchResult({
    required this.videoID,
    required this.title,
    required this.desc,
    required this.pubDate,
    required this.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return {
      'videoID': videoID,
      'title': title,
      'desc': desc,
      'pubDate': pubDate,
      'thumbnail': thumbnail,
    };
  }

  factory SearchResult.fromMap(Map<String, dynamic> map) {
    return SearchResult(
      videoID: map["id"]["videoId"] ?? '',
      title: map["snippet"]["title"] ?? '',
      desc: map["snippet"]["description"] ?? '',
      pubDate: map["snippet"]["publishedAt"] ?? '',
      thumbnail: map["snippet"]["thumbnails"]["default"]["url"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchResult.fromJson(String source) =>
      SearchResult.fromMap(json.decode(source));
}
