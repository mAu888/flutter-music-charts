import 'package:flutter/material.dart';
import 'package:music_charts/api/apiclient.dart';
import 'package:music_charts/artist.dart';
import 'package:music_charts/bloc/artists_charts_page_bloc.dart';
import 'package:music_charts/common/charts_grid.dart';
import 'package:music_charts/common/charts_page.dart';
import 'package:music_charts/common/screen.dart';
import 'package:music_charts/pages/artist_detail_page.dart';

class ArtistChartsPage extends StatelessWidget {
  final ArtistsChartsPageBLoC _bloc = ArtistsChartsPageBLoC(ApiClient());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.artists,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Screen(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "An error occured. Please retry in a bit.",
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
            ),
          );
        } else {
          return ChartsPage<Artist>(
            items: snapshot.data,
            transform: (item) =>
                ChartItem(title: item.name, imageUrl: item.imageUrl),
            onTap: (artist) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArtistDetailPage(artist: artist),
                )),
          );
        }
      },
    );
  }
}
