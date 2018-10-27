import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget child;
  final String title;

  const Screen({Key key, @required this.child, @required this.title})
      : assert(child != null),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: child,
    );
  }
}
