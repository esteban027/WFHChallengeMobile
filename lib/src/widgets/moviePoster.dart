import 'package:WFHchallenge/src/models/Movie.dart';
import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  
  final double heigthMovie = 145;
  final double widthMovie = 99;
  final double _widthRating = 48;
  final Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  final Color _blue = Color.fromRGBO(28, 31, 44, 1);
  final Color _orange = Color.fromRGBO(235, 89, 25, 1);
  final BoxShadow boxShadow = BoxShadow( color: Colors.black26, blurRadius: 10.0, spreadRadius: 2.0, offset: Offset(2.0,10.0));
  final BorderRadius borderRadius = BorderRadius.circular(6.0);

  final Movie movie;
  MoviePoster({ @required  this.movie});

  @override
  Widget build(BuildContext context) {
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
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 10,right: 10),
    );
  }
}