import 'package:music_charts/api/apiclient.dart';
import 'package:music_charts/artist.dart';
import 'package:music_charts/artist_metadata.dart';
import 'package:rxdart/rxdart.dart';

class ArtistDetailPageBloC {
  ApiClient _apiClient;
  Observable<ArtistMetadata> _info;

  Observable<ArtistMetadata> get info => _info;

  ArtistDetailPageBloC(Artist artist, this._apiClient)
      : assert(_apiClient != null) {
    _info = Observable.fromFuture(_apiClient.getMetadata(artist.id));
  }
}
