import 'package:flutter/material.dart';
import 'package:music_charts/api/apiclient.dart';
import 'package:music_charts/artist.dart';
import 'package:music_charts/common/charts_grid.dart';
import 'package:music_charts/common/charts_page.dart';

class ArtistChartsPage extends StatefulWidget {
  @override
  ArtistChartsPageState createState() {
    return new ArtistChartsPageState();
  }
}

class ArtistChartsPageState extends State<ArtistChartsPage> {
  ApiClient _apiClient = ApiClient();
  List<Artist> _artists;

  @override
  void initState() {
    _apiClient
        .getAlbumCharts()
        .then((value) => setState(() => _artists = value))
        .catchError(
            (error) => print('Failed to receive response, error: $error'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChartsPage<Artist>(
      items: _artists,
      transform: (item) => ChartItem(title: item.name, imageUrl: item.imageUrl),
      onTap: (artist) => print('tapped on ${artist.name}'),
    );
  }
}
