import 'package:WFHchallenge/src/Events/pages_events.dart';
import 'package:WFHchallenge/src/States/movies_states.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/models/Movie.dart';
import 'package:WFHchallenge/src/providers/provider.dart';
import 'package:WFHchallenge/src/widgets/MoviesGallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopMovieFilter extends StatefulWidget {
  final String title;
  final LoadMoviesBloc bloc;
  final PageEvent event;

  TopMovieFilter(
      {Key key,
      @required this.title,
      @required this.bloc,
      @required this.event})
      : super(key: key);

  @override
  _TopMovieFilterState createState() =>
      _TopMovieFilterState(title, bloc, event);
}

class _TopMovieFilterState extends State<TopMovieFilter> {
  String title;
  LoadMoviesBloc bloc;
  PageEvent event;

  _TopMovieFilterState(this.title, this.bloc, this.event);

  final provider = new Provider();

  Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  Color _orange = Color.fromRGBO(235, 89, 25, 1);

  List<Movie> movies = [];

  @override
  Widget build(BuildContext context) {
    bloc.add(event);

    return CupertinoPageScaffold(
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              _sortBy(),
              _moviesGallery(),
            ],
          ),
        ),
        decoration: BoxDecoration(color: Color.fromRGBO(28, 31, 44, 1)),
      ),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color.fromRGBO(28, 31, 44, 1),
      ),
    );
  }

  Widget _moviesGallery() {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, state) {
                if (state is MoviesLoaded) {
                  return MoviesGallery(
                    movies: state.moviesPage.items,
                  );
                }
                return Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }

  Widget _sortBy() {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        width: width - 50,
        height: 50,
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
              child: Image.asset(
                'assets/Sort.png',
                color: Colors.white,
              ),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10),
            )
          ],
        ),
        margin: EdgeInsets.only(top: 10),
      ),
      onTap: (){
        // _settingModalBottomSheet(context);
        bottomSheet();
      },
    );
  }

  void bottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          color: Colors.transparent,
          child: Container(
            child: Column(
              children: <Widget>[
                Container (
                  child: Row( children: <Widget>[
                      Text(
                        'Sort By',
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Image.asset(
                          'assets/Sort.png',
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.all(20),
                ),
                ListTile(
                  title: Text('data'),
                  onTap: (){
                    print('data');
                  },
                )

              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: _blue
            ),
          ),
        );
      }
    );
  }
  void _settingModalBottomSheet(context){
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Row(
            children: <Widget>[
              Text('Sort by',
                style: TextStyle(
                //  color: Colors.white,
                 fontSize: 20
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Image.asset(
                  'assets/Sort.png',
                  // color: Colors.white,
                ),
              )
            ],
          ),
          cancelButton: CupertinoActionSheetAction(
            onPressed: (){Navigator.of(context).pop();},
            child: Text('Cancel')
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: (){
                print('Rating');
              }, 
              child: Text(
                'Best Rating',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 15
                ),
              )
            ),
            CupertinoActionSheetAction(
              onPressed: (){
                print('title');
              },
              child: Text(
                'Alphabetical by title',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 15
                ),
              )
            ),
            CupertinoActionSheetAction(
              onPressed: (){
                print('date');
              },
              child: Text(
                'Release date',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 15
                ),
              )
            )
          ],
        );
      }
    );
  }
}
