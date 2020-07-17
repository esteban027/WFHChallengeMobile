import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/Events/sections_events.dart';
import 'package:WFHchallenge/src/States/sections_states.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/blocs/sections_bloc.dart';
import 'package:WFHchallenge/src/models/sections_page_model.dart';
import 'package:WFHchallenge/src/models/user_model.dart';
import 'package:WFHchallenge/src/pages/top_movie_bygenre_view.dart';
import 'package:WFHchallenge/src/pages/top_movie_filter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:WFHchallenge/src/resources/sign_in_repository.dart';

enum TypeOfCard { normal, splited }

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final moviesBloc = LoadMoviesBloc();
  final sectionsBloc = LoadSectionsBloc();

  final _darkblue = Color.fromRGBO(22, 25, 39, 1.0);
  final _orange = Color.fromRGBO(235, 89, 25, 1);
  UserModel user;

  List<String> categories = [];

  List<String> moviesDescription = ['Movie title', '', '', 'Movie title'];
  List<SectionModel> sections = [];
  int userId = 0;

  bool isFirstLaunch = true;
  @override
  void initState() {
    super.initState();
    sectionsBloc.add(FetchAllHomeSections());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        child: _blocBuilder(),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/gradient.png'), fit: BoxFit.cover)),
      ),
    );
  }

  Widget _blocBuilder() {
    return Container(
      child: Column(
        children: <Widget>[
          _title(),
          Container(
            child: BlocBuilder(
                bloc: sectionsBloc,
                builder: (BuildContext context, state) {
                  if (state is SectionLoaded) {
                    sections = state.sectionsPage.items;
                    return _drawSections();
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: _orange,
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation(_darkblue),
                    ),
                  );
                }),
            height: MediaQuery.of(context).size.height * 0.75,
          ),
        ],
      ),
    );
  }

  void getuser(SignInRepository signInRepository) async {
    user = await signInRepository.getUserInfo();

    setState(() {});
  }

  Widget _title() {
    if (isFirstLaunch) {
      final signInRepository =
          Provider.of<SignInRepository>(context, listen: false);

      getuser(signInRepository);
      isFirstLaunch = !isFirstLaunch;
    }

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
      child: Column(
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
              user != null
                  ? Text(
                      user.name.split(' ').first,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w100),
                      textAlign: TextAlign.center,
                    )
                  : Container(
                      child: CircularProgressIndicator(
                        backgroundColor: _orange,
                        strokeWidth: 1,
                        valueColor: AlwaysStoppedAnimation(_darkblue),
                      ),
                      width: 5,
                      height: 5,
                    ),
            ], mainAxisAlignment: MainAxisAlignment.center),
          ),
          Container(
            child: Text(
              'Welcome to HeyMovie',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(top: 5),
          ),
        ],
      ),
    );
  }

  Widget _drawSections() {
    List<Widget> sectionWidgets = [];

    for (var i = 0; i <= sections.length; i += 3) {
      sectionWidgets.add(normalCategory(i));
      if (i + 2 < sections.length) {
        sectionWidgets.add(splitCategory(i + 2));
      }
    }

    return ListView(children: sectionWidgets);
  }

  Widget normalCategory(int section) {
    return GestureDetector(
      child: _section(TypeOfCard.normal, sections[section]),
      onTap: () {
        final String title = sections[section].id.split("!")[0];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TopMovieFilter(
                      title: title,
                      event: section == 0
                          ? FetchTopMovies()
                          : FetchMoviesRecommendationToUser(user.id),
                      userId: user.id,
                    ),
                maintainState: false,
                fullscreenDialog: false));
      },
    );
  }

  Widget splitCategory(int section) {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: _section(TypeOfCard.splited, sections[section - 1]),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TopMovieFilter(
                          title: sections[section - 1].id,
                          event: FetchTopMoviesByLatestRelease(),
                        )));
          },
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        GestureDetector(
          child: _section(TypeOfCard.splited, sections[section]),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TopMovie(
                          bloc: moviesBloc,
                        )));
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget _section(TypeOfCard type, SectionModel sectionModel) {
    final width = (MediaQuery.of(context).size.width);
    final double heigthMovie = type == TypeOfCard.normal ? 227 : 150;
    final double widthMovie =
        type == TypeOfCard.normal ? width : (width * 0.385);

    final BorderRadius borderRadius = BorderRadius.circular(11.0);
    final Color _blue = Color.fromRGBO(28, 31, 44, 1);
    return Container(
      child: Stack(
        children: <Widget>[
          ClipRRect(
            child: FadeInImage(
              placeholder: AssetImage('assets/defaultcover.png'),
              image: NetworkImage(sectionModel.posterPath),
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
                    sectionModel.id,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    child: sectionModel.description != ' '
                        ? Text(
                            sectionModel.description,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w100),
                          )
                        : null,
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
        left: type == TypeOfCard.normal ? 35 : 0,
        right: type == TypeOfCard.normal ? 35 : 0,
        top: 20,
      ),
    );
  }
}
