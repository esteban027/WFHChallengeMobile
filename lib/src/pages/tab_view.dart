import 'package:WFHchallenge/hey_movie_icons.dart';
import 'package:WFHchallenge/src/Events/watchlist_events.dart';
import 'package:WFHchallenge/src/pages/filter_genres_page.dart';
import 'package:WFHchallenge/src/pages/home_view.dart';
import 'package:WFHchallenge/src/pages/watch_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabView extends StatefulWidget {
  int user;

  TabView(this.user);

  @override
  _TabViewState createState() => _TabViewState(user);
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  String userName = '';
  int user;

  _TabViewState(this.user);

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
        resizeToAvoidBottomInset: false,
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
            ),
            BottomNavigationBarItem(
              icon: Icon(HeyMovie.watchlistwachtlist),
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
            case 2:
              return CupertinoTabView(
                builder: (context) {
                  return WatchListView(
                    event: FetchWatchlistByUser(user),
                    userId: user,
                  );
                },
              );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
