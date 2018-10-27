import 'package:meta/meta.dart';

@immutable
class Track {
  final String id;
  final String name;
  final String imageUrl;
  final int playCount;

  const Track({this.id, this.name, this.imageUrl, this.playCount});

  Track.fromJson(Map<String, dynamic> json)
      : id = json['mbid'],
        name = json['name'],
        imageUrl = (json['image']).firstWhere((item) {
          return item['size'] == 'medium';
        })['#text'],
        playCount = int.parse(json['playcount']);
}
