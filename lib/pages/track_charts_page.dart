import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_charts/api/apiclient.dart';
import 'package:music_charts/bloc/track_charts_page_bloc.dart';
import 'package:music_charts/common/screen.dart';
import 'package:music_charts/common/when_loading.dart';
import 'package:music_charts/track.dart';

class TrackChartsPage extends StatelessWidget {
  final NumberFormat _numberFormat = NumberFormat.compact();
  final TrackChartsPageBLoC _bloc = TrackChartsPageBLoC(ApiClient());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.artists,
      builder: (context, snapshot) {
        return Screen(
          title: "Track charts",
          child: _buildChild(context, snapshot),
        );
      },
    );
  }

  Widget _buildChild(
      BuildContext context, AsyncSnapshot<List<Track>> snapshot) {
    if (snapshot.hasError) {
      return _buildErrorMessage(context);
    } else {
      return WhenLoading(
        isLoading: !snapshot.hasData,
        builder: () => _buildChartsPage(snapshot.data),
      );
    }
  }

  Widget _buildChartsPage(List<Track> tracks) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      itemCount: tracks.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(tracks[index].name),
            subtitle: Text("Playcount: ${_numberFormat.format(tracks[index].playCount)}"),
            leading: ClipOval(
              child: CachedNetworkImage(
                imageUrl: tracks[index].imageUrl,
              ),
            ),
          ),
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }

  Widget _buildErrorMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          "An error occured. Please retry in a bit.",
          style: Theme.of(context).textTheme.body1,
        ),
      ),
    );
  }
}
