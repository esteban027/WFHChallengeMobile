import 'package:WFHchallenge/src/Events/watchlist_events.dart';
import 'package:WFHchallenge/src/blocs/watchlist_bloc.dart';
import 'package:WFHchallenge/src/models/Movie.dart';
import 'package:WFHchallenge/src/models/page_model.dart';
import 'package:WFHchallenge/src/models/watchlist_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoviePoster extends StatefulWidget {
  final MovieModel movie;
  final int user;
  final bool isOnWatchList;

  MoviePoster({@required this.movie, this.user, this.isOnWatchList});

  @override
  _MoviePosterState createState() => _MoviePosterState();
}

class _MoviePosterState extends State<MoviePoster> {
  final double heigthMovie = 145;

  final double widthMovie = 99;

  final double _widthRating = 48;

  final Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  final Color _blue = Color.fromRGBO(28, 31, 44, 1);
  final Color _orange = Color.fromRGBO(235, 89, 25, 1);
  bool isOnWatchList = false;

  final BoxShadow boxShadow = BoxShadow(
      color: Colors.black26,
      blurRadius: 10.0,
      spreadRadius: 2.0,
      offset: Offset(2.0, 10.0));

  final BorderRadius borderRadius = BorderRadius.circular(6.0);

  final bloc = WatchlistBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                child: FadeInImage(
                  placeholder: AssetImage('assets/defaultcover.png'),
                  image: NetworkImage(widget.movie.posterPath),
                  height: heigthMovie,
                  width: widthMovie,
                  fit: BoxFit.cover,
                ),
                borderRadius: borderRadius,
              ),
              Container(
                width: widthMovie,
                height: 145,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.transparent, _blue],
                  stops: [0.0, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
              ),
              Positioned(
                child: Container(
                  child: GestureDetector(
                    child: isOnWatchList
                        ? SvgPicture.asset(
                            'assets/Icons/Checkcheck.svg',
                            color: Colors.white,
                            fit: BoxFit.scaleDown,
                          )
                        : Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 10.5,
                          ),
                    onTap: () {
                      setState(() {
                        var timeStapFromatted =
                            ((DateTime.now().millisecondsSinceEpoch) / 1000)
                                .round();
                        var watchlist = WatchlistModel.buildLocal(
                            widget.user, widget.movie.id, timeStapFromatted);
                        isOnWatchList = !isOnWatchList;

                        bloc.add(AddToWatchlist(watchlist));
                      });
                    },
                  ),
                  decoration: BoxDecoration(
                    color:
                        isOnWatchList ? _orange : Color.fromRGBO(0, 0, 0, 0.9),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        topLeft: Radius.circular(14)),
                  ),
                  width: 23,
                  height: 24,
                ),
                top: 14,
                right: 0,
              ),
              Positioned(
                bottom: 11,
                left: (widthMovie / 2) - (_widthRating / 2),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      Text(
                        widget.movie.rating.toStringAsFixed(1),
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                      Container(
                        child: Image.asset(
                          'assets/Star.png',
                          color: Colors.white,
                        ),
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
                      borderRadius: BorderRadius.circular(14), color: _orange),
                ),
              ),
            ],
            fit: StackFit.passthrough,
          ),
          Container(
            child: Text(
              widget.movie.title,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
            width: widthMovie,
            margin: EdgeInsets.only(left: 15, top: 10),
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 10, right: 10),
    );
  }
}
