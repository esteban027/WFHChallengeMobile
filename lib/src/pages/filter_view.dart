
import 'package:WFHchallenge/src/States/movies_states.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/providers/provider.dart';
import 'package:WFHchallenge/src/search/search_delegate.dart';
import 'package:WFHchallenge/src/widgets/MoviesGallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FilterView extends StatefulWidget {
  FilterView({Key key}) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  
  // final provider =  Provider();
  final moviesBloc = LoadMoviesBloc();

  @override
  Widget build(BuildContext context) {
    // provider.getMovies();
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
        BlocBuilder(
          bloc: moviesBloc,
          builder: (BuildContext context, state){
            if (state is MoviesLoaded){
              setState(() {
                return MoviesGallery(
                  movies: state.moviesPage.items,
                );
              });
            }
            return Center(child: CircularProgressIndicator());
          }
        )
       ],
     ),
   );
 }
}
