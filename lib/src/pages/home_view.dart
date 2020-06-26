import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/models/user_model.dart';
import 'package:WFHchallenge/src/pages/top_movie_bygenre_view.dart';
import 'package:WFHchallenge/src/pages/top_movie_filter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:WFHchallenge/src/resources/sign_in_repository.dart';

enum TypeOfCard { normal, splited }

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final moviesBloc = LoadMoviesBloc();
  final _darkblue = Color.fromRGBO(22, 25, 39, 1.0);
  final _orange = Color.fromRGBO(235, 89, 25, 1);

  List<String> categories = [
    'Top 100! You should watch them!',
    'Best Latest \n releases',
    'Top Movies \n by Genre',
    ' Best Movies of all time'
  ];

  List<String> moviesDescription = ['Movie title', '', '', 'Movie title'];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        child: ListView(
          children: homeLayout2(),
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/gradient.png'), fit: BoxFit.cover)),
      ),
    );
  }

  List<Widget> homeLayout2() {
    int section = 0;
    List<Widget> tops = [];
    tops.add(_title());
    int counter = 0;

    categories.forEach((movie) {
      if (section < categories.length) {
        if (counter == 0) {
          tops.add(normalCategory(section));
          section += 1;
          counter += 2;
        } else {
          tops.add(splitCategory(section));
          section += 2;
          counter = 0;
        }
      }
    });

    return tops;
  }

  Widget _title() {
    final signInRepository =
        Provider.of<SignInRepository>(context, listen: false);
    final user = signInRepository.getUserInfo();
    return Column(
      children: <Widget>[
        Container(
          child: Row(children: <Widget>[
            Text(
              'Hey',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            FutureBuilder<UserModel>(
              future: user,
              builder:
                  (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data.name.split(' ').first,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w100),
                      textAlign: TextAlign.center,
                    );
                  }
                  return Container(
                    child: CircularProgressIndicator(
                      backgroundColor: _orange,
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation(_darkblue),
                    ),
                    width: 20,
                    height: 20,
                  );
                }
                return CircularProgressIndicator(
                  backgroundColor: _orange,
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation(_darkblue),
                );
              },
            )
          ], mainAxisAlignment: MainAxisAlignment.center),
          margin: EdgeInsets.only(top: 40),
        ),
        Container(
          child: Text(
            'Welcome to HeyMovie',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          margin: EdgeInsets.only(top: 5),
        ),
      ],
    );
  }

  Widget normalCategory(int section) {
    return GestureDetector(
      child: _section(TypeOfCard.normal, section),
      onTap: () {
        final String title = categories[section].split('!')[0];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TopMovieFilter(
                      title: title,
                      bloc: moviesBloc,
                      event: FetchTopMovies(page: null),
                    )));
      },
    );
  }

  Widget splitCategory(int section) {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: _section(TypeOfCard.splited, section),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TopMovieFilter(
                          title: categories[section],
                          bloc: moviesBloc,
                          event: FetchTopMoviesByLatestRelease(),
                        )));
          },
        ),
        GestureDetector(
          child: _section(TypeOfCard.splited, section + 1),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TopMovie(
                          bloc: moviesBloc,
                        )));
          },
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget _section(TypeOfCard type, int section) {
    final width = (MediaQuery.of(context).size.width);
    final double heigthMovie = type == TypeOfCard.normal ? 227 : 150;
    final double widthMovie = type == TypeOfCard.normal ? width : width - 250;

    final BorderRadius borderRadius = BorderRadius.circular(6.0);
    final Color _blue = Color.fromRGBO(28, 31, 44, 1);

    return Container(
      child: Stack(
        children: <Widget>[
          ClipRRect(
            child: FadeInImage(
              placeholder: AssetImage('assets/defaultcover.png'),
              image: NetworkImage(
                  'http://image.tmdb.org/t/p/w185//uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg'),
              height: heigthMovie,
              width: widthMovie,
              fit: BoxFit.cover,
            ),
            borderRadius: borderRadius,
          ),
          Container(
            width: widthMovie,
            height: heigthMovie,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, _blue],
                stops: [0.0, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: borderRadius,
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    categories[section],
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    child: Text(
                      moviesDescription[section],
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                    padding: EdgeInsets.only(left: 2),
                  ),
                ],
              ),
              width: widthMovie,
              padding: EdgeInsets.only(left: 15),
              height: 47,
            ),
          ),
        ],
        fit: StackFit.passthrough,
      ),
      margin: EdgeInsets.only(
        left: type == TypeOfCard.normal ? 35 : 10,
        right: type == TypeOfCard.normal ? 35 : 10,
        top: 20,
      ),
    );
  }
}
