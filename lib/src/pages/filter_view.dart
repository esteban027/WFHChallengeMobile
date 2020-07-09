import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/Events/pages_events.dart';
import 'package:WFHchallenge/src/States/movies_states.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/models/page_model.dart';
import 'package:WFHchallenge/src/pages/top_movie_filter_view.dart';
import 'package:WFHchallenge/src/search/search_delegate.dart';
import 'package:WFHchallenge/src/widgets/MoviesGallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterView extends StatefulWidget {
  final LoadMoviesBloc moviesBloc;
  final PageEvent event;
  final List<String> genres;

  FilterView(
      {Key key,
      @required this.moviesBloc,
      @required this.event,
      @required this.genres})
      : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState(moviesBloc, event, genres);
}

class _FilterViewState extends State<FilterView> {
  final LoadMoviesBloc moviesBloc;
  final PageEvent event;
  final List<String> genres;

  List<String> selectedGenres = [];
  Map<String, bool> genresState = {};
  TypeOfFilter type = TypeOfFilter.withuotFilter;

  final darkBlue = Color.fromRGBO(28, 31, 44, 1);
  final _orange = Color.fromRGBO(235, 89, 25, 1);
  Color _genreColor = Color.fromRGBO(28, 31, 44, 1);
  Color _bestRating = Colors.white;
  Color _alfabetical = Colors.white;
  Color _release = Colors.white;
  Color _darkBlue = Color.fromRGBO(22, 25, 39, 1);
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  bool shouldEnable = false;
  bool firstLaunch = true;
  String _selectedGenresString = '';

  _FilterViewState(this.moviesBloc, this.event, this.genres);

  @override
  Widget build(BuildContext context) {
    if (firstLaunch) {
      genres.forEach((genre) {
        genresState[genre] = false;
      });

      genresState[genres.first] = true;

      // in the first launch , the first category appear selected by default

      if (selectedGenres.isEmpty) {
        selectedGenres.add(genres.first);
        _selectedGenresString = genres.first;
      }

      firstLaunch = false;
    } else {
      selectedGenres = [];
      genresState.forEach((key, value) {
        if (value == true) {
          selectedGenres.add(key);
          shouldEnable = true;
        }
      });

      if (selectedGenres.isEmpty) {
        selectedGenres = genres;
      }

      _selectedGenresString = '';

      for (var i = 0; i < selectedGenres.length; i++) {
        _selectedGenresString = _selectedGenresString + ' ' + selectedGenres[i];
      }
    }

    moviesBloc.add(ReturnToInitialState());
    moviesBloc.add(FetchMoviesByGenres(selectedGenres));
    shouldEnable = false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 31, 44, 1),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              genresRow(),
              _sortBy(_selectedGenresString),
              _moviesGallery(event),
            ],
          ),
        ),
        decoration: BoxDecoration(color: Color.fromRGBO(28, 31, 44, 1)),
      ),
    );
  }

  Widget genresRow() {
    List<Widget> rows = [];
    int index = 0;

    genres.forEach((genre) {
      rows.add(Container(
        child: GestureDetector(
          child: Center(
            child: Text(
              genre,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          onTap: () {
            setState(() {
              genresState[genre] = !genresState[genre];
              if (genresState[genre]) {
                selectedGenres.add(genre);
              } else {
                selectedGenres.remove(genre);
              }
            });
          },
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: genresState[genre] ? _orange : _darkBlue,
        ),
        height: 32,
        width: 155,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      ));
      index++;
    });

    return Container(
      child: ListView(
        children: rows,
        scrollDirection: Axis.horizontal,
      ),
      height: MediaQuery.of(context).size.height * 0.074,
    );
  }

  Widget _moviesGallery(PageEvent event) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.57,
        child: BlocBuilder(
            bloc: moviesBloc,
            builder: (BuildContext context, state) {
              if (state is MoviesLoaded) {
                final filteredmovies = filter(state.moviesPage.items, type);
                return MoviesGallery(movies: filteredmovies
                    // nextPage: () => moviesBloc.add(event),
                    );
              } else if (state is MoviesLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  Widget _sortBy(String title) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        width: width - 50,
        height: 50,
        color: _darkBlue,
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                'Top movies by: $title',
                style: TextStyle(color: Colors.white, fontSize: 15),
                overflow: TextOverflow.fade,
              ),
              margin: EdgeInsets.only(left: 15),
              width: width - 100,
            ),
            Spacer(),
            Container(
              child: Image.asset(
                'assets/Sort.png',
                color: Colors.white,
              ),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10),
            )
          ],
        ),
        margin: EdgeInsets.only(top: 10),
      ),
      onTap: () {
        bottomSheet();
      },
    );
  }

  List<MovieModel> filter(List<MovieModel> movies, TypeOfFilter type) {
    switch (type) {
      case TypeOfFilter.rating:
        movies.sort((a, b) => a.rating.compareTo(b.rating));
        break;
      case TypeOfFilter.title:
        movies.sort((a, b) => a.title.compareTo(b.title));
        break;
      case TypeOfFilter.releaseDate:
        movies.sort((a, b) =>
            a.releaseDate.toString().compareTo(b.releaseDate.toString()));
        break;
      default:
    }
    return movies;
  }

  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            height: 250,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Text('Sort By',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13)),
                        Container(
                          child: Image.asset(
                            'assets/Sort.png',
                            color: Colors.white,
                          ),
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(left: 10),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.white,
                  ),
                  ListTile(
                    title: Text('Best Rating',
                        style: TextStyle(
                            color: _bestRating,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                    onTap: () {
                      // print('Best Rating');
                      setState(() {
                        _bestRating = _orange;
                        _alfabetical = Colors.white;
                        _release = Colors.white;
                        type = TypeOfFilter.rating;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Alphabetical by title',
                        style: TextStyle(
                            color: _alfabetical,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                    onTap: () {
                      // print('Alphabetical by title');
                      setState(() {
                        _alfabetical = _orange;
                        _bestRating = Colors.white;
                        _release = Colors.white;
                        type = TypeOfFilter.title;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Release date',
                        style: TextStyle(
                            color: _release,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                    onTap: () {
                      setState(() {
                        _release = _orange;
                        _bestRating = Colors.white;
                        _alfabetical = Colors.white;
                        type = TypeOfFilter.releaseDate;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: _blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
            ),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
  }
}
