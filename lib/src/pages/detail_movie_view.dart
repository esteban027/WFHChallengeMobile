import 'package:WFHchallenge/src/Events/ratings_events.dart';
import 'package:WFHchallenge/src/States/ratings_states.dart';
import 'package:WFHchallenge/src/blocs/ratings_bloc.dart';
import 'package:WFHchallenge/src/models/Movie.dart';
import 'package:WFHchallenge/src/models/page_model.dart';
import 'package:WFHchallenge/src/models/ratings_page_model.dart';
import 'package:WFHchallenge/src/widgets/chart.dart';
import 'package:WFHchallenge/src/widgets/chart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailMovieView extends StatefulWidget {
  DetailMovieView({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final MovieModel movie;
  @override
  _DetailMovieViewState createState() => _DetailMovieViewState();

  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData(
      RatingsPageModel ratings) {
    List<TimeSeriesSales> data = _timeStampsToDate(ratings);
    List<TimeSeriesSales> dataPoints = _timeStampsToDate(ratings);

    dataPoints.forEach((element) {
      print(element.sales);
    });

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Score',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(235, 89, 25, 1)),
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      ),
      charts.Series<TimeSeriesSales, DateTime>(
          id: 'ScorePoints',
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: dataPoints)
        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }

  static List<TimeSeriesSales> _timeStampsToDate(RatingsPageModel ratings) {
    int counter = 0;
    List<DateTime> dates = [];
    List<TimeSeriesSales> points = [];

    ratings.items.forEach((rating) {
      dates.add(DateTime.fromMillisecondsSinceEpoch(rating.timestamp * 1000));
    });

    dates.forEach((element) {
      points.add(TimeSeriesSales(element, ratings.items[counter].rating));
      counter++;
    });

    return points;
  }
}

class _DetailMovieViewState extends State<DetailMovieView> {
  final double heigthMovie = 309;
  final double widthMovie = 99;
  final Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  final Color _blue = Color.fromRGBO(28, 31, 44, 1);
  final Color _orange = Color.fromRGBO(235, 89, 25, 1);
  final Color _blueContainer = Color.fromRGBO(40, 65, 109, 0.10);
  Color _buttonColor = Colors.grey;
  List<Color> starsColor = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey
  ];

  final ratingBloc = LoadRatingsBloc();

  @override
  Widget build(BuildContext context) {
    final double widthContainer = MediaQuery.of(context).size.width - 80;
    ratingBloc.add(FetchRatingsByMovieId(widget.movie.id));

    List<String> genres = widget.movie.genre.split('|');

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: _imageAndRating(context),
          ),
          Row(
            children: <Widget>[
              Spacer(),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        bottomSheet();
                      },
                      child: Image.asset(
                        'assets/Star.png',
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Rate it',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {},
                      child: Image.asset(
                        'assets/review.png',
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Add Review',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {},
                      child: Image.asset(
                        'assets/Add.png',
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Add to watchlist',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
          Container(
            color: _blueContainer,
            margin: EdgeInsets.only(right: 20, left: 20, top: 10),
            child: Column(
              children: <Widget>[
                // TITLE
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      widget.movie.title,
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  color: _darkBlue,
                  width: MediaQuery.of(context).size.width - 40,
                  height: 52,
                ),

                // MOVIE INFO

                Center(
                  child: Container(
                    color: _darkBlue,
                    width: widthContainer,
                    height: 85,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        _movieInfo(),
                        Spacer(),
                        _genres(genres),
                      ],
                    ),
                  ),
                ),

                // Description

                Center(
                  child: Container(
                    child: Text(
                      widget.movie.description,
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    width: widthContainer,
                    height: 90,
                    margin: EdgeInsets.only(top: 11),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: _blueContainer,
            margin: EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      'Movie Score',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  color: _darkBlue,
                  width: MediaQuery.of(context).size.width - 40,
                  height: 52,
                  // margin: EdgeInsets.only(top: 11),
                ),
                BlocBuilder(
                    bloc: ratingBloc,
                    builder: (BuildContext context, state) {
                      if (state is RatingsLoaded) {
                        // return _graph(context,state.ratingsPage);
                        return LineChartSample1(state.ratingsPage);
                      } else if (state is RatingsLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ],
            ),
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
          Text(
            widget.movie.rating.toStringAsFixed(1),
            style: TextStyle(color: _blue, fontSize: 15),
          ),
          Container(
            child: Image.asset('assets/Star.png', color: _blue),
            width: 12.8,
            height: 12.8,
            padding: EdgeInsets.only(left: 1),
          ),
          Spacer(),
          Column(
            children: <Widget>[
              Spacer(),
              Text(
                widget.movie.voteCount.toString(),
                style: TextStyle(color: _blue, fontSize: 11),
              ),
              Text(
                'Ratings',
                style: TextStyle(color: _blue, fontSize: 11),
              ),
              Spacer(),
            ],
          ),
          Spacer(),
        ],
      ),
      width: 124,
      height: 47,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
          color: Colors.white),
    );
  }

  Widget _imageAndRating(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          child: FadeInImage(
            placeholder: AssetImage('assets/defaultcover.png'),
            image: NetworkImage(widget.movie.posterPath),
            height: 309,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 309,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.transparent, _blue],
            stops: [0.0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
        Positioned(bottom: 18, right: 0, child: _ratingWidget()),
        Positioned(
          top: 30,
          left: 0,
          child: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ],
      fit: StackFit.passthrough,
    );
  }

  Widget _movieInfo() {
    return Container(
      child: Column(
        children: _movieInfoRows(),
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      margin: EdgeInsets.only(left: 10),
    );
  }

  Widget _genres(List<String> genresStrings) {
    List<Widget> genresColumn = [];
    List<Widget> genresRow = [];

    genresStrings.forEach((genreTitle) {
      genresRow.add(
        Container(
          child: Center(
              child: Text(
            genreTitle,
            style: TextStyle(color: Colors.white, fontSize: 11),
          )),
          width: 68,
          height: 17,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: _orange, borderRadius: BorderRadius.circular(14)),
        ),
      );
    });
    if (genresRow.length > 1) {
      for (var i = 0; i < genresRow.length; i += 2) {
        if (genresRow.length == i + 1) {
          genresColumn.add(genresRow[i]);
        } else {
          genresColumn.add(Row(
            children: <Widget>[genresRow[i], genresRow[i + 1]],
            mainAxisAlignment: MainAxisAlignment.center,
          ));
        }
      }
    } else {
      genresColumn.add(genresRow[0]);
    }

    return Container(
      child: Column(
        children: genresColumn,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      margin: EdgeInsets.only(right: 15),
    );
  }

  List<Widget> _movieInfoRows() {
    String date = widget.movie.releaseDate == null
        ? 'No date'
        : DateTime.parse(widget.movie.releaseDate).year.toString();
    return [
      Container(
        child: Row(
          children: <Widget>[
            Text(
              'Release: ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              date,
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ),
        width: 100,
      ),
    ];
  }

  Widget numberAndStart(int number, StateSetter setStateSheet) {
    return Container(
      child: FlatButton(
          onPressed: () {
            print(number.toString());
            setStateSheet() {
              starsColor[number - 1] = _orange;
              _buttonColor = _orange;
            }
            // setState(() {
            //   starsColor[number - 1] = _orange;
            //   _buttonColor = _orange;
            // });
          },
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  number.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                margin: EdgeInsets.only(bottom: 15),
              ),
              Image.asset(
                'assets/Star.png',
                color: starsColor[number - 1],
                width: 22,
                height: 22,
              ),
            ],
          )),
      width: 50,
    );
  }

  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateSheet) {
            // return Container(
            //   height: 250,
            //   color: _buttonColor,
            //   child: RaisedButton(onPressed: () {
            //     setStateSheet(() {
            //       _buttonColor = Colors.pinkAccent;
            //     });
            //   },
            //   child: Text('data'),
            //   color:  _buttonColor,
            //   ),
            // );

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
                          Text('Rate this movie here',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13)),
                        ],
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.white,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Spacer(),
                                // numberAndStart(1, setStateSheet),
                                Container(
                                  child: FlatButton(
                                      onPressed: () {
                                        print(1.toString());
                                        setStateSheet() {
                                          starsColor[1 - 1] = _orange;
                                          _buttonColor = _orange;
                                        }
                                        setState(() {
                                          starsColor[1 - 1] = _orange;
                                          _buttonColor = _orange;
                                        });
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              1.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            margin: EdgeInsets.only(bottom: 15),
                                          ),
                                          Image.asset(
                                            'assets/Star.png',
                                            color: _buttonColor,
                                            width: 22,
                                            height: 22,
                                          ),
                                        ],
                                      )),
                                  width: 50,
                                ),
                                Spacer(),
                                numberAndStart(2, setStateSheet),
                                Spacer(),
                                numberAndStart(3, setStateSheet),
                                Spacer(),
                                numberAndStart(4, setStateSheet),
                                Spacer(),
                                numberAndStart(5, setStateSheet),
                                Spacer(),
                              ],
                            ),
                            padding: EdgeInsets.only(top: 31, bottom: 43),
                          ),
                        ],
                      ),
                    )
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
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
  }
}
