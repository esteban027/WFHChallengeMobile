import 'package:WFHchallenge/src/models/Movie.dart';
import 'package:WFHchallenge/src/widgets/chart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DetailMovieView extends StatelessWidget {
  DetailMovieView({Key key, @required this.movie,}) : super(key: key);

    final Movie movie;
    final double heigthMovie = 309;
    final double widthMovie = 99;
    final double _widthRating = 48;
    final Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
    final Color _blue = Color.fromRGBO(28, 31, 44, 1);
    final Color _orange = Color.fromRGBO(235, 89, 25, 1);
    final _borderRadius = BorderRadius.circular(6.0);

  @override
  Widget build(BuildContext context) {
    List<String> genres = movie.genres.split('|');

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
                      onPressed: (){},
                      child: Image.asset(
                        'assets/Star.png',
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Rait it',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white
                      ),
                    )
                  ],
                ) ,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){},
                      child: Image.asset(
                        'assets/review.png',
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Add Review',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white
                      ),
                    )
                  ],
                ) ,
              ),
            Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){},
                      child: Image.asset(
                        'assets/Add.png',
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Add to watchlis',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white
                      ),
                    )
                  ],
                ) ,
              ),
              Spacer(),
            ],
          ),
          Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Text(
                  movie.getTitle(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              color: _darkBlue,
              width: MediaQuery.of(context).size.width - 40,
              height: 52,
              margin: EdgeInsets.only(top: 11),
            ),
          ),
          Center(
            child: Container(
              color: _darkBlue,
              width: MediaQuery.of(context).size.width - 80,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  _movieInfo(),
                  Spacer(),
                  _genres(genres),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              child: Text(
                movie.description,
                style: TextStyle(
                color: Colors.white,
                fontSize: 11
                ),
              ),
              width: MediaQuery.of(context).size.width - 100,
              height: 90,
              margin: EdgeInsets.only(top: 11),
            ),
          ),
          Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Text(
                  'Movie Score',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              color: _darkBlue,
              width: MediaQuery.of(context).size.width - 40,
              height: 52,
              margin: EdgeInsets.only(top: 11),
            ),
          ),
          Center(
            child: Container(
              height: 300,
              color: _blue,
              width: MediaQuery.of(context).size.width - 40,
              child: EndPointsAxisTimeSeriesChart(_createSampleData()),
            ),
          )
        ],
      ),
      backgroundColor: _blue,
    );
  }
  
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 1, 19), 1),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 1.2),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 3.2),
      new TimeSeriesSales(new DateTime(2017, 12, 10), 4),
      new TimeSeriesSales(new DateTime(2018, 1, 19), 1),
      new TimeSeriesSales(new DateTime(2018, 2, 26), 2),
      new TimeSeriesSales(new DateTime(2018, 10, 3), 3),
      new TimeSeriesSales(new DateTime(2020, 1, 10), 5),
      new TimeSeriesSales(new DateTime(2020, 3, 19), 4.8),
      new TimeSeriesSales(new DateTime(2020, 5, 26), 4.5),
    ];

    final dataPoints = [
      new TimeSeriesSales(new DateTime(2017, 1, 19), 1),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 1.2),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 3.2),
      new TimeSeriesSales(new DateTime(2017, 12, 10), 4),
      new TimeSeriesSales(new DateTime(2018, 1, 19), 1),
      new TimeSeriesSales(new DateTime(2018, 2, 26), 2),
      new TimeSeriesSales(new DateTime(2018, 10, 3), 3),
      new TimeSeriesSales(new DateTime(2020, 1, 10), 5),
      new TimeSeriesSales(new DateTime(2020, 3, 19), 4.8),
      new TimeSeriesSales(new DateTime(2020, 5, 26), 4.5),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Score',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color.fromRGBO(235, 89, 25, 1)),
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      ),

      charts.Series<TimeSeriesSales, DateTime>(
        id: 'ScorePoints',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: dataPoints
      )
        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }

  Widget _ratingWidget() {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(),
          Text(movie.rating.toStringAsFixed(1),style: TextStyle(color: _blue, fontSize: 15),),
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
              Text(movie.voteCount.toString(),style: TextStyle(color: _blue, fontSize: 11),),
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
        ),
        Positioned(
          top: 30,
          left: 0,
          child: FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white,),
          ),
        ),
      ],
      fit: StackFit.passthrough,
    );
  }

  Widget _movieInfo(){
    return Container(
      child: Column(
        children: _movieInfoRows(),
      ),
      margin: EdgeInsets.only(left: 10),
    );
  }

  Widget _genres(List<String> genresStrings){
    List<Widget> genresColumn = [];
    List<Widget> genresRow = [];
    int counter = 0;

    genresStrings.forEach((genreTitle) {
      genresRow.add(
        Container(
          child: Center(child: Text(genreTitle, style: TextStyle(color: Colors.white, fontSize: 11),)),
          width: 72,
          height: 17,
          decoration:  BoxDecoration(
            color: _orange,
            borderRadius: BorderRadius.circular(14)
          ),
        ),
      );
    });
    if (genresRow.length > 1) {
      for (var i = 0; i < genresRow.length; i += 2 ) {
        if (genresRow.length == i+1){
           genresColumn.add(genresRow[i]);
        } else {
          genresColumn.add(
            Row(
              children: <Widget>[
                genresRow[i],
                genresRow[i+1] 
              ],
            )
          );
        }
      }
    } else {
      genresColumn.add(genresRow[0]);
    }

  return Column(
    children: genresColumn
  );
}

  List<Widget> _movieInfoRows(){
    return [
      Container(
        child: Row(
          children: <Widget>[
            Text('Time: ', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),),
            Text('1h:40 m', style: TextStyle(color: Colors.white, fontSize: 11),),
          ],
        ),
         width: 100,
      ),
      Container(
        child: Row(
          children: <Widget>[
            Text('Release: ', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),),
            Text('2019', style: TextStyle(color: Colors.white, fontSize: 11),),
          ],
        ),
        width: 100,
      ),
      Container(
        child: Row(
          children: <Widget>[
            Text('Director: ', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),),
            Text('juachito', style: TextStyle(color: Colors.white, fontSize: 11),),
          ],
        ),
        width: 100,
      )
    ];
  }
}