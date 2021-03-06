import 'dart:async';
import 'dart:io';
import 'dart:convert' show utf8, json;

import 'package:music_charts/api/keys.dart';
import 'package:music_charts/artist.dart';
import 'package:music_charts/artist_metadata.dart';
import 'package:music_charts/track.dart';

class ApiClient {
  final _keys = Keys();
  final _host = 'ws.audioscrobbler.com';
  final _client = HttpClient();

  ApiClient() {
    _client.connectionTimeout = Duration(seconds: 30);
  }

  Future<List<Artist>> getAlbumCharts() async {
    final uri = await _createGetUri('chart.gettopartists');
    return _get(uri, (data) {
      Map<String, dynamic> object = data;
      List<dynamic> list = object['artists']['artist'];
      return list.map((artist) => Artist.fromJson(artist)).toList();
    });
  }

  Future<List<Track>> getTrackCharts() async {
    final uri = await _createGetUri('chart.gettoptracks');
    return _get(uri, (data) {
      Map<String, dynamic> object = data;
      List<dynamic> list = object['tracks']['track'];
      return list.map((track) => Track.fromJson(track)).toList();
    });
  }

  Future<List<Track>> getTopTracks(String id) async {
    final uri = await _createGetUri('artist.gettoptracks', { 'mbid': id });
    return _get(uri, (data) {
      Map<String, dynamic> object = data;
      List<dynamic> list = object['toptracks']['track'];
      return list.map((track) => Track.fromJson(track)).toList();
    });
  }

  Future<ArtistMetadata> getMetadata(String id) async {
    final uri = await _createGetUri('artist.getinfo', { 'mbid': id });
    return _get(uri, (data) {
      Map<String, dynamic> object = data;
      return ArtistMetadata.fromJson(object['artist']);
    });
  }

  Future<T> _get<T>(Uri url, T Function(dynamic) transformer) async {
    final request = await _client.getUrl(url);
    final response = await request.close();

    if (response.statusCode != 200) {
      throw ('The request returned an invalid status code');
    }

    final responseBody = await response.transform(utf8.decoder).join();
    final jsonObject = json.decode(responseBody);
    return transformer(jsonObject);
  }

  Future<Uri> _createGetUri(String method,
      [Map<String, String> queryParameters]) async {
    final key = await _keys.getApiKey();
    queryParameters = queryParameters ?? {};
    final defaultQueryParameters = {
      'method': method,
      'api_key': key,
      'format': 'json'
    };

    queryParameters.addAll(defaultQueryParameters);

    return Uri(
      host: _host,
      scheme: 'https',
      path: '2.0',
      queryParameters: queryParameters,
    );
  }
}
