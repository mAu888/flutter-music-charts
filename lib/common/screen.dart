import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget child;

  const Screen({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Last.fm Charts'),
      ),
      body: child,
    );
  }
}
