import 'package:WFHchallenge/src/providers/provider.dart';
import 'package:WFHchallenge/src/widgets/MoviesGallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopMovieFilter extends StatefulWidget {
  final String title;
  TopMovieFilter({Key key,@required this.title}) :  super(key: key);
  
  @override
  _TopMovieFilterState createState() => _TopMovieFilterState(title);
}

class _TopMovieFilterState extends State<TopMovieFilter> {
  String title;

  _TopMovieFilterState(this.title);

  final provider = new Provider();
  
  Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  Color _orange = Color.fromRGBO(235, 89, 25, 1);

  @override
  Widget build(BuildContext context) {
    provider.getMovies();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 31, 44, 1)
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              _sortBy(),
              _moviesGallery(),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(28, 31, 44, 1)
        ),
      ),
    );
  }

  Widget _moviesGallery() {
   return Container(
     width: double.infinity,
     child: Column(
       children: <Widget>[
         StreamBuilder(
           stream: provider.moviesStream,
           builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
             if (snapshot.hasData) {
              return MoviesGallery(
                movies: snapshot.data, 
                nextPage: provider.getMovies,
              );
             }
             return Center(child: CircularProgressIndicator());
           },
         ),
       ],
     ),
   );
 }

  Widget _sortBy(){  
    double width = MediaQuery.of(context).size.width;
    return  GestureDetector(
      child: Container(
        width: width - 50,
        height: 52,
        color: _darkBlue,
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                'Top movies by $title',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              margin: EdgeInsets.only(left: 15),
            ),
            Spacer(),
            Container(
              child: Image.asset('assets/Sort.png',color: Colors.white,),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10),
            )
          ],
        ),
        margin: EdgeInsets.only(top: 10),
      ),
      onTap: (){
        print('filter by');
      },
    );
  }
}