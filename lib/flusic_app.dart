import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_charts/common/scene_navigator.dart';
import 'package:music_charts/pages/artist_charts_page.dart';
import 'package:music_charts/pages/track_charts_page.dart';

enum FlusicAppTab { globalCharts, userCharts }

class FlusicApp extends StatefulWidget {
  @override
  FlusicAppState createState() {
    return new FlusicAppState();
  }
}

class FlusicAppState extends State<FlusicApp> {
  final Map<FlusicAppTab, GlobalKey<NavigatorState>> _navigatorKeys = {
    FlusicAppTab.globalCharts: GlobalKey(),
    FlusicAppTab.userCharts: GlobalKey(),
  };

  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'last.fm Charts',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator(
              tab: FlusicAppTab.globalCharts,
              child: ArtistChartsPage(),
            ),
            _buildOffstageNavigator(
              tab: FlusicAppTab.userCharts,
              child: TrackChartsPage(),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Offstage _buildOffstageNavigator(
      {@required Widget child, @required FlusicAppTab tab}) {
    return Offstage(
      offstage: _selectedIndex != tab.index,
      child: SceneNavigator(
        navigatorKey: _navigatorKeys[tab],
        initialRoute: "/",
        routes: {
          "/": (BuildContext context) => child,
        },
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (selectedIndex) {
        setState(() {
          _selectedIndex = selectedIndex;
        });
      },
      items: _buildNavigationBarItems(),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        title: Text("Artist"),
        icon: Icon(FontAwesomeIcons.user),
      ),
      BottomNavigationBarItem(
        title: Text("Tracks"),
        icon: Icon(FontAwesomeIcons.compactDisc),
      ),
    ];
  }
}
