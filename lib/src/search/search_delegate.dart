import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/States/movies_states.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/models/Movie.dart';
import 'package:WFHchallenge/src/models/page_model.dart';
import 'package:WFHchallenge/src/pages/detail_movie_view.dart';
import 'package:WFHchallenge/src/widgets/MoviesGallery.dart';
import 'package:WFHchallenge/src/widgets/moviePoster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataSearch extends SearchDelegate {
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  // final provider = new Provider();
  final LoadMoviesBloc moviesBloc;

  DataSearch(this.moviesBloc);

  String selecter = '';

  List<MovieModel> movies = [];
  final _scrollController = new ScrollController(
    debugLabel: 'scroll',
  );
  List<MovieModel> movies2 = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    moviesBloc.add(FetchMoviesByTitle(query));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        // provider.getMovies();
      }
    });

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
    FocusScopeNode currentFocuts = FocusScope.of(context);
    if (!currentFocuts.hasPrimaryFocus) {
      currentFocuts.unfocus();
    }
    return Container(
        child: MoviesGallery(
          movies: movies2,
          userId: null,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/gradient.png'),
            fit: BoxFit.cover,
          ),
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      child: Container(
        child: BlocBuilder(
            bloc: moviesBloc,
            builder: (BuildContext context, state) {
              if (state is MoviesLoaded) {
                //inal moviesFilter = (query.isEmpty) ? movies2 : state.moviesPage.items.where((movie) => movie.title.toLowerCase().contains(query.toLowerCase())).toList();
                movies2 = state.moviesPage.items;
                return GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: (99 / 145),
                  controller: _scrollController,
                  children:
                      List.generate(state.moviesPage.items.length, (index) {
                    return GestureDetector(
                      child: MoviePoster(movie: state.moviesPage.items[index]),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailMovieView(
                                      movie: state.moviesPage.items[index],
                                      userId: null,
                                    )));
                      },
                    );
                  }),
                );

                //   return MoviesGallery(movies: state.moviesPage.items);
              }
              return Center(child: CircularProgressIndicator());
            }),
        //  height: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/gradient.png'),
          fit: BoxFit.cover,
        ),
      ),
      // color: Colors.green,
    );
  }
}
