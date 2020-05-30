import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {

    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home)
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search
            )
          )

        ],
      ),
      tabBuilder: (BuildContext context, int index){
        assert(index >= 0 && index <= 2);
        switch(index) {
          case 0:
          return HomeTabView();
            break;
        case 1:
          return CupertinoActivityIndicator(
            radius: 32,
            animating: false,
          );
          break;
        }
        return null;
      },
    ),
    );
  }
}

class HomeTabView extends StatelessWidget {
const HomeTabView();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

          Align(
            alignment: Alignment(0,-0.6),
            child:  Text(
              'Welcome to HeyMovie',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,

            ),
          ),
      GridView.count(crossAxisCount: 2,
      children: List.generate(4, (index) {
        return Center(
        child: Text(
        'Item $index',
         style: Theme.of(context).textTheme.headline5,
        ),
        );
    }),
      ),
      ],
    );
  }
}


