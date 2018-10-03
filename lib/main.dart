import 'package:flutter/material.dart';
import 'package:music_charts/common/screen.dart';
import 'pages/charts_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'last.fm Charts',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Screen(
        child: ChartsPage(),
      ),
    );
  }
}
