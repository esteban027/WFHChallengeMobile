
import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/search/search_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'filter_view.dart';

class FilterGenresView extends StatefulWidget {
  FilterGenresView({Key key}) : super(key: key);

  @override
  _FilterGenresViewState createState() => _FilterGenresViewState();
}

class _FilterGenresViewState extends State<FilterGenresView> {
  final genres = ['Animation', 'Action', 'Adventure', 'Biography', 'Comedy', 'Crime', 'Drama', 'Documentary', 'Fantasy', 'Historical', 'Horror'];
  Map<String,bool> genresState = {'Animation': false, 'Action': false, 'Adventure': false , 'Biography': false, 'Comedy': false, 'Crime': false, 'Drama': false, 'Documentary': false, 'Fantasy': false, 'Historical': false, 'Horror': false};
  Color _buttonColor = Colors.grey;
  final moviesBloc = LoadMoviesBloc();

  @override
  Widget build(BuildContext context) {

    List<String> selectedGenres = [];

    genresState.forEach((key, value) {
      if (value == true){
        selectedGenres.add(key);
      }
    });

    return  Scaffold(
      backgroundColor: Color.fromRGBO(28, 31, 44, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 31, 44, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ]
      ),
      body:  Center(
        child: Container(
          child: Column(
            children: <Widget>[
              _filterTitle(),
              _checkboxList(),
              _filterButton(selectedGenres)
            ],
          ),
          color: Color.fromRGBO(28, 31, 44, 1),
          margin: EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _filterTitle() {
    return Container(
      child: Text('Filters by Genres',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15, 
        ),
      ),
      padding: EdgeInsets.only(left: 15,top: 17),
      color: Color.fromRGBO(22, 25, 29, 1),
      height: 52,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _checkboxList() {
    return Container(
      height: MediaQuery.of(context).size.height - 330,
      child: ListView.builder(
        itemCount: genres.length,
        itemBuilder: (BuildContext context, int index) {
          final genre = genres[index];
          return CheckboxListTile(
            onChanged: (value){
              setState(() {
                _buttonColor = Color.fromRGBO(235, 89, 25, 1);
                genresState[genre] = value;
              });
            },
            value: genresState[genre],
            title: Text(
              genres[index],
              style: TextStyle(
                color: Colors.white,
                fontSize: 14
              ),
            ),
            activeColor: Color.fromRGBO(235, 89, 25, 1),
          );
        },
      ),
    );
  }

  Widget _filterButton(List<String> selectedGenres) {
    return RaisedButton(
      onPressed: (){
        Navigator.push(
          context, MaterialPageRoute (
            builder: (context) => FilterView(
              moviesBloc: moviesBloc, 
              event: FetchMoviesByGenres(selectedGenres),
            )
          )
        );
      },
      child: Text('Apply filter'),
      padding: EdgeInsets.only(left: 140, right: 140, top: 13, bottom: 13),
      color: _buttonColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}