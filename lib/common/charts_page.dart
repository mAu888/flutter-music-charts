import 'package:flutter/material.dart';
import 'package:music_charts/common/charts_grid.dart';
import 'package:music_charts/common/screen.dart';
import 'package:music_charts/common/when_loading.dart';

class ChartsPage<T> extends StatelessWidget {
  final List<T> items;
  final ChartItem Function(T) transform;
  final Function(T) onTap;

  const ChartsPage({Key key, this.items, @required this.transform, this.onTap})
      : assert(transform != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: WhenLoading(
          isLoading: items == null,
          builder: () => ChartsGrid(
                onTap: (index) => onTap != null ? onTap(items[index]) : () {},
                items: items.map((item) => transform(item)).toList(),
              ),
        ),
      ),
    );
  }
}
