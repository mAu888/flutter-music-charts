import 'package:flutter/material.dart';
import 'package:music_charts/api/apiclient.dart';
import 'package:music_charts/artist.dart';
import 'package:music_charts/bloc/artist_detail_page_bloc.dart';
import 'package:music_charts/common/screen.dart';

class ArtistDetailPage extends StatelessWidget {
  final Artist artist;

  final ArtistDetailPageBloC _bloc;

  ArtistDetailPage({Key key, this.artist})
      : assert(artist != null),
        _bloc = ArtistDetailPageBloC(artist, ApiClient()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ConstrainedBox(
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.blueGrey),
            ),
            constraints: BoxConstraints.expand(height: 240.0),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  artist.name,
                  style: Theme.of(context).textTheme.display1,
                ),
                StreamBuilder(
                  stream: _bloc.info,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data.shortBio,
                        style: Theme.of(context).textTheme.body1,
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Container();
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "Tracks",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 8.0),
                  child: Text(
                    "Track $index",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                );
              },
              separatorBuilder: (context, _) {
                return Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 1.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
