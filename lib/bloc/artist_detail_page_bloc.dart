import 'package:music_charts/api/apiclient.dart';
import 'package:music_charts/artist.dart';
import 'package:music_charts/artist_metadata.dart';
import 'package:music_charts/track.dart';
import 'package:rxdart/rxdart.dart';

class ArtistDetailPageBloC {
  ApiClient _apiClient;

  Observable<ArtistMetadata> _info;
  Observable<List<Track>> _tracks;

  Observable<ArtistMetadata> get info => _info;
  Observable<List<Track>> get tracks => _tracks;

  ArtistDetailPageBloC(Artist artist, this._apiClient)
      : assert(_apiClient != null) {
    _info = Observable.fromFuture(_apiClient.getMetadata(artist.id))
        .shareReplay(maxSize: 1);
    _tracks = Observable.fromFuture(_apiClient.getTopTracks(artist.id))
        .shareReplay(maxSize: 1);
  }
}
