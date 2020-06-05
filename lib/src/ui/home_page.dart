import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/models/page_model.dart';
import 'package:WFHchallenge/src/pages/filter_genres_page.dart';
import 'package:WFHchallenge/src/pages/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/movies_bloc.dart';
import '../Events/movies_events.dart';
import '../resources/repository.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    final moviesBloc = LoadMoviesBloc();
    Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
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
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home,color: Color.fromRGBO(235, 89, 25, 1),)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.search, color:  Color.fromRGBO(235, 89, 25, 1),))
          ],
          backgroundColor: _blue,
        ),
        tabBuilder: (BuildContext context, int index) {
          assert(index >= 0 && index <= 2);
          switch (index) {
            case 0:
              return BlocBuilder(
                bloc: moviesBloc, 
                builder: (BuildContext context, state) { 
                  return CupertinoTabView(
                    builder: (context){
                      return HomeView();
                    },
                  );
                }
              );
              break;
            case 1:
              return CupertinoTabView(
                builder: (context){
                  return FilterGenresView();
                },
              );
            break;
          }
          return null;
        },
      ),
    );
  }
}