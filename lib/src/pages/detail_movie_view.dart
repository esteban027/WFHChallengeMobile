import 'package:WFHchallenge/src/models/Movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailMovieView extends StatelessWidget {
  DetailMovieView({Key key, @required this.movie,}) : super(key: key);

    final Movie movie;
    final double heigthMovie = 309;
    final double widthMovie = 99;
    final double _widthRating = 48;
    // final Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
    final Color _blue = Color.fromRGBO(28, 31, 44, 1);
    final Color _orange = Color.fromRGBO(235, 89, 25, 1);
    // final BoxShadow boxShadow = BoxShadow( color: Colors.black26, blurRadius: 10.0, spreadRadius: 2.0, offset: Offset(2.0,10.0));
    final _borderRadius = BorderRadius.circular(6.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: _imageAndRating(context),
          ),
          Row(
            children: <Widget>[
              Spacer(),
              Icon(Icons.arrow_back, color: Colors.white),
              Icon(Icons.arrow_back, color: Colors.white),
              Icon(Icons.arrow_back, color: Colors.white),
              Spacer(),
            ],
          ),
        ],
      ),
      backgroundColor: _blue,
    );
  }

  Widget _ratingWidget() {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(),
          Text('9.8',style: TextStyle(color: _blue, fontSize: 15),),
          Container(
            child: Image.asset('assets/Star.png',color: _blue),
            width: 12.8,
            height: 12.8,
            padding: EdgeInsets.only(left: 1),
          ),
          Spacer(),
          Column(
            children: <Widget>[
              Spacer(),
              Text('5.421',style: TextStyle(color: _blue, fontSize: 11),),
              Text('Ratings',style: TextStyle(color: _blue, fontSize: 11),),
              Spacer(),
            ],
          ),
          Spacer(),
        ],
      ),
      width: 124,
      height: 47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
        color: Colors.white
      ),
    );
  }

  Widget _imageAndRating(BuildContext context){
    return Stack(
      children: <Widget>[
        ClipRRect(
          child:  FadeInImage(
            placeholder: AssetImage('assets/defaultcover.png'), 
            image:  NetworkImage(movie.getPosterImage()),
            height: 309,
            width: MediaQuery.of(context). size. width,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: MediaQuery.of(context). size. width,
          height: 309,
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
          bottom: 18,
          right: 0,
          child: _ratingWidget()
        )
      ],
      fit: StackFit.passthrough,
    );
  }
}