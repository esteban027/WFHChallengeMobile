import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/Events/pages_events.dart';
import 'package:WFHchallenge/src/Events/watchlist_events.dart';
import 'package:WFHchallenge/src/States/movies_states.dart';
import 'package:WFHchallenge/src/States/watchlist_states.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/blocs/watchlist_bloc.dart';
import 'package:WFHchallenge/src/models/page_model.dart';
import 'package:WFHchallenge/src/widgets/MoviesGallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum TypeOfFilter { rating, title, releaseDate, withuotFilter }

class WatchListView extends StatefulWidget {
  final PageEvent event;
  final int userId;

  WatchListView({Key key, @required this.event, this.userId}) : super(key: key);

  @override
  _WatchListViewState createState() => _WatchListViewState(event, userId);
}

class _WatchListViewState extends State<WatchListView> {
  final watchListBloc = WatchlistBloc();
  final moviesBloc = LoadMoviesBloc();

  final int userId;
  PageEvent event;
  int page = 1;
  Color _bestRating = Colors.white;
  Color _alfabetical = Colors.white;
  Color _release = Colors.white;
  TypeOfFilter type = TypeOfFilter.withuotFilter;
  List<MovieModel> movies = [];
  _WatchListViewState(this.event, this.userId);

  Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  Color _orange = Color.fromRGBO(235, 89, 25, 1);
  double heightOfModalBottomSheet = 200;
  bool shouldReloadMovies = true;
  bool showEmptyView = false;

  @override
  Widget build(BuildContext context) {
    watchListBloc.add(FetchWatchlistByUser(userId));
    return WillPopScope(
      onWillPop: () {
        return Navigator.maybePop(context);
      },
      child: CupertinoPageScaffold(
        child: Container(
          child: Column(
            children: <Widget>[
              // Spacer(),
              _sortBy(),
              _moviesGallery(),
              Spacer()
            ],
          ),
          decoration: BoxDecoration(color: Color.fromRGBO(28, 31, 44, 1)),
        ),
      ),
    );
  }

  Widget _moviesGallery() {
    final filteredmovies = filter(movies, type);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      child: shouldReloadMovies
          ? BlocBuilder(
              bloc: watchListBloc,
              builder: (BuildContext context, state) {
                print(state);
                if (state is WatchlistPublished) {
                  print('object');
                }
                if (state is MovieWatchlistLoaded) {
                  movies = [];
                  var moviesWacthList = state.moviesWatchlist.items;
                  if (moviesWacthList.length > 0) {
                    showEmptyView = false;
                    movies.addAll(state.moviesWatchlist.items);

                    var gallery = MoviesGallery(
                      movies: movies,
                      isFirstCall: true,
                      userId: widget.userId,
                    );

                    return gallery;
                  } else {
                    showEmptyView = true;
                    moviesBloc
                        .add(FetchMoviesRecommendationToUser());
                    return _moviesYouShouldAdd();
                  }
                } else if (state is WatchlistNotLoaded) {
                  showEmptyView = true;
                  moviesBloc
                      .add(FetchMoviesRecommendationToUser());
                  return _moviesYouShouldAdd();
                }

                return Container(
                  child: Center(child: CircularProgressIndicator()),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 400,
                );
              })
          : MoviesGallery(
              movies: filteredmovies,
              userId: widget.userId,
            ),
    );
  }

  Widget _sortBy() {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        width: width - 50,
        height: MediaQuery.of(context).size.height * 0.08,
        color: _darkBlue,
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                'Your Watchlist',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              margin: EdgeInsets.only(left: 15),
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
        margin: EdgeInsets.only(top: 90),
      ),
      onTap: () {
        bottomSheet();
      },
    );
  }

  Widget _moviesYouShouldAdd() {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            'You don’t have movies on your watchlist yet.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.03),
        ),
        Container(
          width: width - 50,
          height: MediaQuery.of(context).size.height * 0.06,
          color: _darkBlue,
          child: Container(
            child: Center(
              child: Text(
                'Movies you should add in your Watchlist',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        _recomendationsGallery()
      ],
    );
  }

  Widget _recomendationsGallery() {
    return Container(
      width: double.infinity,
      height: showEmptyView
          ? MediaQuery.of(context).size.height * 0.55
          : MediaQuery.of(context).size.height * 0.5,
      child: BlocBuilder(
          bloc: moviesBloc,
          builder: (BuildContext context, state) {
            if (state is MoviesLoaded) {
              movies = [];
              movies.addAll(state.moviesPage.items);
              var gallery = MoviesGallery(
                movies: movies,
                isFirstCall: true,
                userId: widget.userId,
              );

              return gallery;
            } else if (state is MoviesNotLoaded) {
              showEmptyView = true;
              print('Movies recomendations not loaded');
              return Container(
                child: Center(child: CircularProgressIndicator()),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 400,
              );
            }

            return Container(
              child: Center(child: CircularProgressIndicator()),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 400,
            );
          }),
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
    shouldReloadMovies = true;
    showModalBottomSheet(
        useRootNavigator: true,
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
