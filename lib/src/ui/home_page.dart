import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/models/page_model.dart';
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

    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.search))
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          assert(index >= 0 && index <= 2);
          switch (index) {
            case 0:
              return BlocBuilder(bloc:moviesBloc, 
          builder: (BuildContext context, state) { 
            return Center(child: CupertinoButton(
              child:Text('Load Movies') ,
              onPressed: () => moviesBloc.add(MoviesEvent.loadAllMovies),
              ),
              );
          }
          );
                  

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

// class HomeTabView extends StatelessWidget {
// const HomeTabView();

//   @override
//   Widget build(BuildContext context) {
//     final moviesBloc = BlocProvider.of<LoadMoviesBloc>(context);
//     return Stack(
//       children: [

//           Align(
//             alignment: Alignment(0,-0.6),
//             child:  Text(
//               'Welcome to HeyMovie',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontStyle: FontStyle.normal,
//                 fontWeight: FontWeight.bold
//               ),
//               textAlign: TextAlign.center,

//             ),
//           ),
//       GridView.count(crossAxisCount: 2,
//       children:widget(
//               child: BlocBuilder(bloc:moviesBloc, builder: (BuildContext context, state) {

//          }
//         ),
//       ),
//       ),
//       ],
//     );
//   }
// }
