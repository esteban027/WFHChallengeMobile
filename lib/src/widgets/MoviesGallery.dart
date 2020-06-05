import 'dart:ui';

import 'package:WFHchallenge/src/models/Movie.dart';
import 'package:WFHchallenge/src/models/page_model.dart';
import 'package:WFHchallenge/src/pages/detail_movie_view.dart';
import 'package:WFHchallenge/src/widgets/moviePoster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MoviesGallery extends StatefulWidget {
  final List<MovieModel> movies ;
  // final Function nextPage;

  // MoviesGallery({ @required this.movies, @required this.nextPage});
   MoviesGallery({ @required this.movies});

  @override
  _MoviesGalleryState createState() => _MoviesGalleryState(movies: movies);
}

class _MoviesGalleryState extends State<MoviesGallery> {
  
  List<MovieModel> movies ;
  // final Function nextPage;

  // _MoviesGalleryState({ @required this.movies, @required this.nextPage});
    _MoviesGalleryState({ @required this.movies});


  List<Widget> rowsOfMovies = List();

  double heigthMovie = 145;
  double widthMovie = 99;
  double _widthRating = 48;
  Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  Color _orange = Color.fromRGBO(235, 89, 25, 1);
  BoxShadow boxShadow = BoxShadow( color: Colors.black26, blurRadius: 10.0, spreadRadius: 2.0, offset: Offset(2.0,10.0));
  BorderRadius borderRadius = BorderRadius.circular(6.0);

  final _scrollController = new ScrollController(
    debugLabel: 'scroll',
  );

  void updateMovies(List <MovieModel> newMovies){
    setState(() {
      movies = newMovies;
    });
  }

  @override
  Widget build(BuildContext context) {

    final  _screenSize = MediaQuery.of(context).size;

    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300) {
        // nextPage(); 
      }
    });

    return Container(
        child: _movieGrid(),
        height: _screenSize.height - 244,
        margin: EdgeInsets.only(top: 10),
    );
  }

  Widget _movieGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
        childAspectRatio: (99/145)
      ),
      itemBuilder: (contex, index){
        return GestureDetector(
          child: MoviePoster(movie: movies[index],),
          onTap: (){
            print(movies[index].title);
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailMovieView(movie: movies[index],)));
          },
        );
      },
      itemCount: movies.length,
      controller: _scrollController,
      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
    );
  }
}