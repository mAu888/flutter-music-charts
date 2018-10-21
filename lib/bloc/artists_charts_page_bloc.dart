import 'package:music_charts/artist.dart';
import 'package:rxdart/rxdart.dart';
import 'package:music_charts/api/apiclient.dart';

class ArtistsChartsPageBLoC {
  ApiClient _apiClient;
  Observable<List<Artist>> _artists;

  Observable<List<Artist>> get artists => _artists;

  ArtistsChartsPageBLoC(this._apiClient) : assert(_apiClient != null) {
    _artists = Observable.fromFuture(_apiClient.getAlbumCharts());
  }
}
