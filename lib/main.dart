import 'package:flutter/material.dart';
import 'package:music_charts/pages/artist_charts_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'last.fm Charts',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: ArtistChartsPage(),
    );
  }
}
