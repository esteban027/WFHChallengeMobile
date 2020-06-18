import 'package:WFHchallenge/src/Events/genres_events.dart';
import 'package:WFHchallenge/src/States/genres_states.dart';
import 'package:WFHchallenge/src/blocs/genres_bloc.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/pages/tab_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenresRecomendationView extends StatefulWidget {
  final String name;

  GenresRecomendationView({@required this.name});
  @override
  _GenresRecomendationViewState createState() =>
      _GenresRecomendationViewState(name: name);
}

class _GenresRecomendationViewState extends State<GenresRecomendationView> {
  final String name;

  _GenresRecomendationViewState({@required this.name});

  final _separatorColor = Color.fromRGBO(40, 65, 109, 1.0);
  final _darkblue = Color.fromRGBO(22, 25, 39, 1.0);
  final _orange = Color.fromRGBO(235, 89, 25, 1);
  final genreColor = Colors.grey;

  bool shouldEnable = false;
  bool firstTime = true;

  final List<String> genres = [];
  Map<String, bool> genresState = {};

  final LoadGenresBloc genreBloc = LoadGenresBloc();

  @override
  Widget build(BuildContext context) {
    List<String> selectedGenres = [];

    genreBloc.add(FetchAllGenres());
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
            _blockBuilder(),
            Spacer(),
            _filterButton(selectedGenres)
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
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            'Hey',
            style: TextStyle(
                fontSize: 27, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Text(name.toString(),
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
      margin: EdgeInsets.only(left: 110, right: 110, top: 80),
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
            if (state is GenresLoaded) {
              if (firstTime) {
                state.genresPage.items.forEach((genre) {
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
        child: Center(child: Text(genre, style: TextStyle(color: Colors.white, fontSize: 14),overflow: TextOverflow.fade,)),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: genresState[genres[index]] ? _orange : genreColor,
          borderRadius: BorderRadius.circular(10)
        ),
      ));
      index++;
    });

    return  GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: (100/45)
      ),
      itemBuilder: (contex, index){
        return GestureDetector(
          child: rows[index],
          onTap: (){
            setState(() {
              genresState[genres[index]] =  !genresState[genres[index]];              
            });
          },
        );
      },
      itemCount: genres.length,
      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
    );
  }

  Widget _filterButton(List<String> selectedGenres) {
    bool isEmpty = selectedGenres.isEmpty;

    return Container(
      child: RaisedButton(
        onPressed: isEmpty ? null :() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TabView()
            )
          );
        },

        child: Text('Apply filter'),
        padding: EdgeInsets.only(left: 140, right: 140, top: 13, bottom: 13),
        color: isEmpty ? Colors.grey : _orange,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        disabledColor: Colors.grey,
      ),
      margin: EdgeInsets.only(bottom: 30),
    );
  }
}