import 'dart:ui';

import 'package:WFHchallenge/src/models/Movie.dart';
import 'package:WFHchallenge/src/widgets/moviePoster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MoviesGallery extends StatefulWidget {
  final List<Movie> movies ;
  final Function nextPage;

  MoviesGallery({ @required this.movies, @required this.nextPage});

  @override
  _MoviesGalleryState createState() => _MoviesGalleryState(movies: movies, nextPage: nextPage);
}

class _MoviesGalleryState extends State<MoviesGallery> {
  
  final List<Movie> movies ;
  final Function nextPage;

  _MoviesGalleryState({ @required this.movies, @required this.nextPage});

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

  @override
  Widget build(BuildContext context) {

    final  _screenSize = MediaQuery.of(context).size;

    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
        child: _movieGrid(),
        height: _screenSize.height - 180,
    );
  }

  Widget _movieGrid() {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: (99/145),
      controller: _scrollController,
      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
      children: List.generate(movies.length, (index) {
        // return _posterBuilder(movie: movies[index]);
        return MoviePoster(movie: movies[index],);
      }),
    );
  }

  Widget _posterBuilder({Movie movie}) {
    return Container(
      child:  Column(
        children: <Widget>[   
          Stack(
            children: <Widget>[
              ClipRRect(
                child:  FadeInImage(
                  placeholder: AssetImage('assets/defaultcover.png'), 
                  image:  NetworkImage(movie.getPosterImage()),
                  height: heigthMovie,
                  width: widthMovie,
                  fit: BoxFit.cover,
                ),
                borderRadius: borderRadius,
              ),
              Container(
                width: widthMovie,
                height: 145,
                decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, _blue],
                    stops: [0.0,1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                ),
              ),
              Positioned(
                bottom: 11,
                left: (widthMovie/2) - (_widthRating/2),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      Text('9.8',style: TextStyle(color: Colors.white, fontSize: 11),),
                      Container(
                        child: Image.asset('assets/Star.png',color: Colors.white,),
                        width: 7.2,
                        height: 7.2,
                        padding: EdgeInsets.only(left: 1),
                      ),
                      Spacer()
                    ],
                  ),
                  width: 48,
                  height: 17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: _orange
                  ),
                ),
              )
            ],
            fit: StackFit.passthrough,
          ),
          Container(
            child: Text(
              movie.getTitle(),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
                style: TextStyle(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
            width: widthMovie,
            // alignment: Alignment.bottomCenter,
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 10,right: 10),
    );
  }
}