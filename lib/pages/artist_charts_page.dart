import 'package:flutter/material.dart';
import 'package:music_charts/api/apiclient.dart';
import 'package:music_charts/artist.dart';
import 'package:music_charts/bloc/artists_charts_page_bloc.dart';
import 'package:music_charts/common/charts_grid.dart';
import 'package:music_charts/common/charts_page.dart';

class ArtistChartsPage extends StatelessWidget {
  final ArtistsChartsPageBLoC _bloc = ArtistsChartsPageBLoC(ApiClient());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.artists,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error,
              style: Theme.of(context).textTheme.body1,
            ),
          );
        } else {
          return ChartsPage<Artist>(
            items: snapshot.data,
            transform: (item) =>
                ChartItem(title: item.name, imageUrl: item.imageUrl),
            onTap: (artist) => print('tapped on ${artist.name}'),
          );
        }
      },
    );
  }
}
