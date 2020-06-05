
import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/States/movies_states.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/providers/provider.dart';
import 'package:WFHchallenge/src/search/search_delegate.dart';
import 'package:WFHchallenge/src/widgets/MoviesGallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FilterView extends StatefulWidget {
  final LoadMoviesBloc moviesBloc;
  final MoviesEvent event;


  FilterView({Key key, @required this.moviesBloc, @required this.event}) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState(moviesBloc, event);
}

class _FilterViewState extends State<FilterView> {
  
  final LoadMoviesBloc moviesBloc;
  final MoviesEvent event;

  _FilterViewState(this.moviesBloc, this.event);

  @override
  Widget build(BuildContext context) {

    moviesBloc.add(event);

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
                return MoviesGallery(
                  movies: state.moviesPage.items,
                );
            }
            return Center(child: CircularProgressIndicator());
          }
        )
       ],
     ),
   );
 }
}
