import 'package:music_charts/api/apiclient.dart';
import 'package:music_charts/track.dart';
import 'package:rxdart/rxdart.dart';

class TrackChartsPageBLoC {
  final ApiClient _apiClient;

  Observable<List<Track>> get artists =>
      Observable.fromFuture(_apiClient.getTrackCharts())
          .shareReplay(maxSize: 1);

  TrackChartsPageBLoC(this._apiClient);
}
