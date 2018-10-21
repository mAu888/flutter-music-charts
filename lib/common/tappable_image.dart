import 'package:flutter/material.dart';

class TappableImage extends StatelessWidget {
  final Widget child;
  final Function() onTap;

  const TappableImage({Key key, @required this.child, this.onTap})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: child,
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
            ),
          ),
        )
      ],
    );
  }
}
