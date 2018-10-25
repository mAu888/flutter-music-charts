import 'package:meta/meta.dart';

@immutable
class Track {
  final String id;
  final String name;
  final int playCount;

  const Track({this.id, this.name, this.playCount});

  Track.fromJson(Map<String, dynamic> json) :
    id = json['mbid'],
    name = json['name'],
    playCount = int.parse(json['playcount']);
}
