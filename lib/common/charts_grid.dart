import 'package:flutter/material.dart';
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
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];

        return TappableImage(
          onTap: () => onTap(index),
          child: Image.network(item.imageUrl, fit: BoxFit.cover),
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