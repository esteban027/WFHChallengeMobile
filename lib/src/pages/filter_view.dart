
import 'package:WFHchallenge/src/providers/provider.dart';
import 'package:WFHchallenge/src/search/search_delegate.dart';
import 'package:WFHchallenge/src/widgets/MoviesGallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FilterView extends StatefulWidget {
  FilterView({Key key}) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  
  final provider = new Provider();
  
  @override
  Widget build(BuildContext context) {
    provider.getMovies();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 31, 44, 1),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
               Row(
                 children: <Widget>[
                  Expanded(child: SizedBox()),
                  Container(
                    child: Image.asset('assets/Group.png',color: Colors.white,),
                    width: 35.18,
                    height: 18.81,
                    margin: EdgeInsets.only(top:22,right: 40),
                  ),
                ],
               ),
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
}
