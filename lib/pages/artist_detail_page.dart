import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:music_charts/api/apiclient.dart';
import 'package:music_charts/artist.dart';
import 'package:music_charts/bloc/artist_detail_page_bloc.dart';
import 'package:music_charts/common/screen.dart';
import 'package:music_charts/track.dart';

class ArtistDetailPage extends StatelessWidget {
  final Artist artist;

  final ArtistDetailPageBloC _bloc;
  final List<_ListItem> _listItems;

  ArtistDetailPage({Key key, this.artist})
      : assert(artist != null),
        _bloc = ArtistDetailPageBloC(artist, ApiClient()),
        _listItems = _buildListItems(artist),
        super(key: key);

  // StreamSubscription<List<Track>> _subscription;

  // @override
  // void initState() {
  //   _bloc = ArtistDetailPageBloC(widget.artist, ApiClient());
  //   _listItems = _buildListItems(widget.artist);

  //   _subscription = _bloc.tracks.take(1).listen((tracks) {
  //     setState(() => _listItems = _buildListItems(widget.artist, tracks));
  //   });

  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _subscription.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 18.0),
        itemCount: _listItems.length,
        itemBuilder: (content, index) {
          final item = _listItems[index];
          if (item is _ListItemImage) {
            return buildImage(item.imageUrl);
          } else if (item is _ListItemHeader) {
            return buildHeader(context, item.title);
          } else if (item is _ListItemBio) {
            return buildShortBio(context);
          } else if (item is _ListItemTopTracks) {
            return StreamBuilder<List<Track>>(
              stream: _bloc.tracks,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return buildLoadingIndicator();
                }

                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return buildTrack(context, snapshot.data[index].name);
                  },
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                );
              },
            );
          } else if (item is _ListItemPadding) {
            return buildPadding(vertical: item.vertical);
          } else {
            throw Exception("Invalid list item type ${item.runtimeType}");
          }
        },
      ),
    );
  }

  Widget buildPadding({double vertical = 0.0}) =>
      ConstrainedBox(constraints: BoxConstraints.tightFor(height: vertical));

  Widget buildHeader(BuildContext context, String title) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.display1,
        ),
      );

  Widget buildTrack(BuildContext context, String title) => InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
      );

  Widget buildSeparator() => Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(height: 1.0),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey),
          ),
        ),
      );

  Widget buildImage(String imageUrl) => ConstrainedBox(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.fitWidth,
        ),
        constraints: BoxConstraints.expand(height: 240.0),
      );

  Widget buildShortBio(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
              stream: _bloc.info,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.shortBio,
                    style: Theme.of(context).textTheme.body1,
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                        "There should be a short bio here, but the network returned an error."),
                  );
                } else {
                  return buildLoadingIndicator();
                }
              },
            )
          ],
        ),
      );

  Widget buildLoadingIndicator() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CircularProgressIndicator(),
        ),
      );
}

abstract class _ListItem {}

class _ListItemHeader extends _ListItem {
  final String title;

  _ListItemHeader(this.title);
  _ListItemHeader.fromArtist(Artist artist) : this(artist.name);
}

class _ListItemImage extends _ListItem {
  final String imageUrl;

  _ListItemImage(Artist artist) : imageUrl = artist.imageUrl;
}

class _ListItemBio extends _ListItem {}

class _ListItemPadding extends _ListItem {
  final double vertical;

  _ListItemPadding(this.vertical);
}

class _ListItemTopTracks extends _ListItem {}

List<_ListItem> _buildListItems(Artist artist) {
  var items = <_ListItem>[
    _ListItemImage(artist),
    _ListItemPadding(18.0),
    _ListItemHeader.fromArtist(artist),
    _ListItemPadding(18.0),
    _ListItemBio(),
    _ListItemPadding(18.0),
    _ListItemHeader("Tracks"),
    _ListItemTopTracks(),
  ];

  return List.unmodifiable(items);
}
