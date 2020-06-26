import 'package:WFHchallenge/src/pages/filter_genres_page.dart';
import 'package:WFHchallenge/src/pages/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TabView extends StatefulWidget {

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String userName = '';


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  Widget build(BuildContext context) {

    Color _blue = Color.fromRGBO(28, 31, 44, 1);
    final Color _orange = Color.fromRGBO(235, 89, 25, 1);

    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
              CupertinoIcons.home,
            )),
              BottomNavigationBarItem(
                icon: Icon(
                CupertinoIcons.search,
              ),
            )
          ],
          backgroundColor: _blue,
          inactiveColor: Colors.white30,
          activeColor: _orange,
        ),
        tabBuilder: (BuildContext context, int index) {
          assert(index >= 0 && index <= 2);
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  return HomeView();
                },
              );
              break;
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return FilterGenresView();
                },
              );
              break;
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
