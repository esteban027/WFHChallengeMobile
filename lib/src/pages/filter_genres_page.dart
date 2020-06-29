import 'package:WFHchallenge/src/Events/sections_events.dart';
import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/States/sections_states.dart';
import 'package:WFHchallenge/src/blocs/sections_bloc.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/models/sections_page_model.dart';
import 'package:WFHchallenge/src/search/search_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter_view.dart';

class FilterGenresView extends StatefulWidget {
  FilterGenresView({Key key}) : super(key: key);

  @override
  _FilterGenresViewState createState() => _FilterGenresViewState();
}

class _FilterGenresViewState extends State<FilterGenresView> {
  final List<String> genres = [];
  Map<String, bool> genresState = {};

  Color _buttonColor = Colors.grey;
  final LoadSectionsBloc genreBloc = LoadSectionsBloc();
  get moviesBloc => LoadMoviesBloc();
  bool shouldEnable = false;
  bool firstTime = true;
  Color _backgroundColor = Color.fromRGBO(28, 31, 44, 1);
  Color _containerColor = Color.fromRGBO(40, 65, 109, 0.10);

  @override
  Widget build(BuildContext context) {

    genreBloc.add(FetchAllGenresSections());

    List<String> selectedGenres = [];
    shouldEnable = false;

    genresState.forEach((key, value) {
      if (value == true) {
        selectedGenres.add(key);
        shouldEnable = true;
      }
    });

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
          backgroundColor: _backgroundColor,
          actions: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  genresState.forEach((key, value) {
                    if (value == true) {
                      shouldEnable = true;
                    }
                  });
                  showSearch(context: context, delegate: DataSearch(moviesBloc));
                },
              ),
              // decoration: BoxDecoration(
              //   color:  Colors.deepOrange, 
              // ),
            )
          ]),
      body: Container(
        child: Column(
          children: <Widget>[
            _filterTitle(),
            Container(
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

                      return _genreChecbox();
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
              height: MediaQuery.of(context).size.height * 0.62,
            ),
            _filterButton(selectedGenres)
          ],
        ),
        color: _containerColor,
        margin: EdgeInsets.only(left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
      ),
    );
  }

  Widget _filterTitle() {
    return Container(
      child: Text(
        'Filters by Genres',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      padding: EdgeInsets.only(left: 15, top: 17),
      color: Color.fromRGBO(22, 25, 29, 1),
      height: 50,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _genreChecbox() {
    List<Widget> rows = [];
    int index = 0;

    genres.forEach((genre) {
      rows.add(Container(
        child: Row(
          children: <Widget>[
            Text(genre, style: TextStyle(color: Colors.white, fontSize: 14)),
            Spacer(),
            Checkbox(
              value: genresState[genre],
              onChanged: (value) {
                setState(() {
                  _buttonColor = Color.fromRGBO(235, 89, 25, 1);
                  genresState[genre] = value;
                });
              },
              activeColor: _buttonColor,
              checkColor: Colors.white,
              
            )
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 15),
      ));
      index++;
    });

    return Container(
      child: ListView(
        children: rows,
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget _filterButton(List<String> selectedGenres) {
    bool isEmpty = selectedGenres.isEmpty;
    return Container(
      child: RaisedButton(
        onPressed: isEmpty
            ? null
            : () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FilterView(
                              moviesBloc: moviesBloc,
                              event: FetchMoviesByGenres(selectedGenres),
                              genres: selectedGenres,
                            )));
              },
        child: Text('Apply filter'),
        color: isEmpty ? Colors.grey : _buttonColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(108)),
        disabledColor: Colors.grey,
      ),
      width: MediaQuery.of(context).size.width ,
    );
  }
}
