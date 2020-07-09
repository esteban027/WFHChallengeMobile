import 'package:WFHchallenge/src/Events/sections_events.dart';
import 'package:WFHchallenge/src/States/sections_states.dart';
import 'package:WFHchallenge/src/blocs/sections_bloc.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/models/user_model.dart';
import 'package:WFHchallenge/src/pages/tab_view.dart';
import 'package:WFHchallenge/src/resources/sign_in_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class GenresRecomendationView extends StatefulWidget {
  final UserModel user;

  GenresRecomendationView({@required this.user});
  @override
  _GenresRecomendationViewState createState() =>
      _GenresRecomendationViewState(user: user);
}

class _GenresRecomendationViewState extends State<GenresRecomendationView> {
  final UserModel user;

  _GenresRecomendationViewState({@required this.user});

  final _separatorColor = Color.fromRGBO(40, 65, 109, 1.0);
  final _darkblue = Color.fromRGBO(22, 25, 39, 1.0);
  final _orange = Color.fromRGBO(235, 89, 25, 1);
  final genreColor = Colors.grey;
  bool showProgress = false;

  bool shouldEnable = false;
  bool firstTime = true;

  final List<String> genres = [];
  Map<String, bool> genresState = {};
  Color _clearBlue = Color.fromRGBO(119, 165, 244, 1);

  final LoadSectionsBloc genreBloc = LoadSectionsBloc();

  @override
  Widget build(BuildContext context) {
    List<String> selectedGenres = [];

    genreBloc.add(FetchAllGenresSections());
    shouldEnable = false;

    genresState.forEach((key, value) {
      if (value == true) {
        selectedGenres.add(key);
        shouldEnable = true;
      }
    });

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            _heyName(),
            Container(
              color: _separatorColor,
              height: 1,
              margin: EdgeInsets.only(left: 27, right: 27, top: 24),
            ),
            _title2(),
            _choseOne(),
            Stack(
              children: <Widget>[
                _blockBuilder(),
                Positioned(
                  child: shouldShowProgreesIndicator(showProgress),
                  left: MediaQuery.of(context).size.width / 2 - 25,
                  top: MediaQuery.of(context).size.height / 8,
                ),
              ],
              fit: StackFit.loose,
            ),
            Spacer(),
            _filterButton(selectedGenres, user)
          ],
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/gradient.png'), fit: BoxFit.cover)),
        padding: EdgeInsets.only(top: 50),
      ),
    );
  }

  Widget _heyName() {
    var userName = user.name.split(' ').first;
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            'Hey',
            style: TextStyle(
                fontSize: 27, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Text(userName,
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w100,
                  color: Colors.white)),
          Text('!',
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w100,
                  color: Colors.white)),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      margin: EdgeInsets.only(left: 110, right: 110, top: 60),
    );
  }

  Widget _title2() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  'What genres do',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 5,
                ),
                Text('you',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                        color: Colors.white)),
              ],
            ),
          ),
          Container(
            child: Text(
              'like most?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
            width: MediaQuery.of(context).size.width,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
      height: 60,
      margin: EdgeInsets.only(left: 33, top: 35),
    );
  }

  Widget _choseOne() {
    return Container(
      child: Center(
          child: Text(
        'Choose one or more genres of your preference.',
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white70),
      )),
      color: _darkblue,
      margin: EdgeInsets.only(left: 22, right: 22, top: 11),
      height: 52,
    );
  }

  Widget _blockBuilder() {
    return Container(
      child: BlocBuilder(
          bloc: genreBloc,
          builder: (BuildContext context, state) {
            if (state is SectionLoaded) {
              if (firstTime) {
                state.sectionsPage.items.forEach((genre) {
                  genres.add(genre.id);
                  genresState[genre.id] = false;
                });
                firstTime = false;
              }

              return _genreContainer();
            }
            return Center(child: CircularProgressIndicator());
          }),
      height: MediaQuery.of(context).size.height - 450,
      margin: EdgeInsets.symmetric(horizontal: 30),
    );
  }

  Widget _genreContainer() {
    List<Widget> rows = [];
    int index = 0;

    genres.forEach((genre) {
      rows.add(Container(
        child: Center(
            child: Text(
          genre,
          style: TextStyle(color: Colors.white, fontSize: 14),
          overflow: TextOverflow.fade,
        )),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: genresState[genres[index]] ? _clearBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue)),
      ));
      index++;
    });

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: (150 / 45)),
      itemBuilder: (contex, index) {
        return GestureDetector(
          child: rows[index],
          onTap: () {
            setState(() {
              genresState[genres[index]] = !genresState[genres[index]];
            });
          },
        );
      },
      itemCount: genres.length,
      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
    );
  }

  Widget shouldShowProgreesIndicator(bool state) {
    return state
        ? Container(
            child: CircularProgressIndicator(
              backgroundColor: _orange,
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation(_darkblue),
            ),
          )
        : SizedBox(
            height: 5,
            width: 5,
          );
  }

  Widget _filterButton(List<String> selectedGenres, UserModel user) {
    bool isEmpty = selectedGenres.isEmpty;
    String genresString = '';
    final signInRepository =
        Provider.of<SignInRepository>(context, listen: false);
    return Container(
      child: RaisedButton(
        onPressed: () async {
          setState(() {
            showProgress = true;
          });

          for (int i = 0; i < selectedGenres.length; i++) {
            if (i == 0) {
              genresString = selectedGenres[i];
            } else {
              genresString += '|' + selectedGenres[i];
            }
          }
          user.genres = genresString;
          await signInRepository.createUser(user);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TabView(user.id)));
        },
        child: Text('Next'),
        padding: EdgeInsets.only(left: 140, right: 140, top: 13, bottom: 13),
        color: isEmpty ? Colors.grey : _orange,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(108)),
        disabledColor: Colors.grey,
      ),
      margin: EdgeInsets.only(bottom: 30),
    );
  }
}
