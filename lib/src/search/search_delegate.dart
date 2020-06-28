import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/States/movies_states.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/models/Movie.dart';
import 'package:WFHchallenge/src/models/page_model.dart';
import 'package:WFHchallenge/src/widgets/MoviesGallery.dart';
import 'package:WFHchallenge/src/widgets/moviePoster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataSearch extends SearchDelegate {
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  final LoadMoviesBloc moviesBloc;

  DataSearch(this.moviesBloc);

  String selecter = '';

  List<MovieModel> movies = [];
  final _scrollController = new ScrollController(
    debugLabel: 'scroll',
  );
  List<Movie> movies2 = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    moviesBloc.add(FetchMoviesByTitle(query));

    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels >=
    //       _scrollController.position.maxScrollExtent - 200) {
    //     // provider.getMovies();
    //   }
    // });

    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Color.fromRGBO(191, 192, 192, 1))),
        primaryColor: _blue,
        primaryTextTheme: theme.primaryTextTheme,
        textTheme: theme.textTheme.copyWith(
            title: theme.textTheme.title.copyWith(color: Colors.grey)));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Container(
        child: BlocBuilder(
            bloc: moviesBloc,
            builder: (BuildContext context, state) {
              if (state is MoviesLoaded) {
                movies.addAll(state.moviesPage.items);
                var gallery = MoviesGallery(
                  movies: movies,
                );
                return gallery;
              }
              return Center(child: CircularProgressIndicator());
            }),
        height: 500,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/gradient.png'), fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: Container(
        child: BlocBuilder(
            bloc: moviesBloc,
            builder: (BuildContext context, state) {
              if (state is MoviesLoaded) {
                // final moviesFilter = (query.isEmpty) ? movies2 : state.moviesPage.items.where((movie) => movie.title.toLowerCase().contains(query.toLowerCase())).toList();
                var gallery = MoviesGallery(
                  movies: state.moviesPage.items,
                );
                return gallery;
              }
              return Center(child: CircularProgressIndicator());
            }),
        height: 500,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/gradient.png'), fit: BoxFit.cover),
      ),
    );
  }
}
