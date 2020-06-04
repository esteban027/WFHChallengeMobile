import 'package:WFHchallenge/icons2_icons.dart';
import 'package:WFHchallenge/src/pages/home_view.dart';
import 'package:WFHchallenge/src/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'filter_genres_page.dart';

class TabBarHomeView extends StatefulWidget {
  TabBarHomeView({Key key}) : super(key: key);

  @override
  _TabBarHomeViewState createState() => _TabBarHomeViewState();
}

class _TabBarHomeViewState extends State<TabBarHomeView> {

final Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
final Color _blue = Color.fromRGBO(28, 31, 44, 1);
final Color _orange = Color.fromRGBO(235, 89, 25, 1);
final Color _tabBar = Color.fromRGBO(37, 62, 103, 1);

  List<Widget> tabs = [
    HomeView(),
    FilterGenresView(),
  ];

 int currentTabIndex = 0;

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: onTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons2.homeLine),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons2.searchLine),
            title: Text('Search/ filter')
          ),
        ],
        selectedLabelStyle: TextStyle(color: _orange),
        selectedItemColor: _orange,
        unselectedItemColor: Colors.grey,
        iconSize: 23.4,
        backgroundColor: _tabBar,
      ),
    );
  }
}