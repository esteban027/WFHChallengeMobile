import 'package:WFHchallenge/src/models/Movie.dart';
import 'package:WFHchallenge/src/providers/provider.dart';
import 'package:WFHchallenge/src/widgets/MoviesGallery.dart';
import 'package:WFHchallenge/src/widgets/moviePoster.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {

  Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  Color _orange = Color.fromRGBO(235, 89, 25, 1);
  final provider = new Provider();

  String selecter = '';

  List<Movie> movies = [];
  final _scrollController = new ScrollController(
    debugLabel: 'scroll',
  );
  List<Movie> movies2 = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    provider.getMovies();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        provider.getMovies();
      }
    });


    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Color.fromRGBO(191, 192, 192, 1) )
      ),
      primaryColor: _blue,
      primaryTextTheme: theme.primaryTextTheme,
      textTheme: theme.textTheme.copyWith(
            title: theme.textTheme.title
                .copyWith(color: Colors.grey))
    );
  }
  
  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = '';
          }, 
        )
      ];
    }

  @override
  Widget buildLeading(BuildContext context) {
    return 
      IconButton(
        icon: Icon(Icons.search),
        onPressed: (){
          close(context, null);
        }, 
      );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.redAccent,
        child: Text(selecter),
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
  return Container(
    child: Container(
      child: StreamBuilder(
       stream: provider.moviesStream,
       builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
         if (snapshot.hasData) {
          movies = snapshot.data;
          print(query);
          final moviesFilter = (query.isEmpty) ? movies2 : movies.where((movie) => movie.title.toLowerCase().startsWith(query.toLowerCase())).toList();
          return GridView.count(
            crossAxisCount: 3,
            childAspectRatio: (99/145),
            controller: _scrollController,
            children: List.generate(moviesFilter.length, (index) {
              return MoviePoster(movie: moviesFilter[index],);
            }),
          );
        }
         return Center(child: CircularProgressIndicator());
       },          
      ),
     height: 500,
   ),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/gradient.png'),
        fit: BoxFit.cover
      ),
    ),
  );
}

}