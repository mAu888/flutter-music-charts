import 'package:flutter/material.dart';

class SceneNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;
  final Map<String, WidgetBuilder> routes;

  const SceneNavigator({
    Key key,
    this.navigatorKey,
    @required this.initialRoute,
    @required this.routes,
  })  : assert(initialRoute != null),
        assert(routes != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: initialRoute,
      onGenerateRoute: (routeSettings) =>
          MaterialPageRoute(builder: routes[routeSettings.name]),
    );
  }
}
