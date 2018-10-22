import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:music_charts/common/tappable_image.dart';

class ChartItem {
  final String title;
  final String imageUrl;

  const ChartItem({@required this.title, @required this.imageUrl})
      : assert(title != null),
        assert(imageUrl != null);
}

class ChartsGrid extends StatelessWidget {
  final List<ChartItem> items;
  final Function(int) onTap;

  const ChartsGrid({Key key, @required this.items, @required this.onTap})
      : assert(items != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];

        return TappableImage(
          onTap: () => onTap(index),
          child: Stack(
            children: [
              Positioned(
                left: 0.0,
                top: 0.0,
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  placeholder: DecoratedBox(
                    decoration:
                        BoxDecoration(color: Theme.of(context).disabledColor),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.title, style: Theme.of(context).textTheme.subhead,),
                  ),
                  decoration: BoxDecoration(color: Colors.white70),
                ),
              )
            ],
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
    );
  }
}
