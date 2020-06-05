import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/States/movies_states.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/models/page_model.dart';
import 'package:WFHchallenge/src/pages/top_movie_filter_view.dart';
import 'package:WFHchallenge/src/providers/provider.dart';
import 'package:WFHchallenge/src/resources/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopMovie extends StatefulWidget {
  final LoadMoviesBloc bloc;
  TopMovie({Key key, @required this.bloc}) : super(key: key);

  @override
  _TopMovieState createState() => _TopMovieState(bloc);
}

class _TopMovieState extends State<TopMovie> {
  final LoadMoviesBloc bloc;
  final provider = new Provider();
  final network = Network();
  final double widthMovie = 187;
  final double heigthMovie = 128;
  final Color _blue = Color.fromRGBO(28, 31, 44, 1);
  final BorderRadius borderRadius = BorderRadius.circular(6.0);
  final genres = ['Animation', 'Action', 'Adventure', 'Biography', 'Comedy', 'Crime', 'Drama', 'Documentary', 'Fantasy', 'Historical', 'Horror'];

  _TopMovieState(this.bloc);

  final LoadMoviesBloc bloc2 = LoadMoviesBloc();

  @override
  Widget build(BuildContext context) {

    bloc2.add(FetchTopMovies());
    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: _blue,
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text('Top Movies by Gender', style: TextStyle(fontSize: 23, color: Colors.white),),
              margin: EdgeInsets.only(top: 15,bottom: 20),
            ),
            BlocBuilder(
              bloc: bloc2,
              builder: (BuildContext context, state){
                if (state is MoviesLoaded){
                  return topMovieCollection(state.moviesPage.items, context);
                }
                return Center(child: CircularProgressIndicator());
              }
            )
          ],
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/gradient.png'),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }

  Widget topMovieCollection(List<MovieModel> movies, BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: (157/108)
      ),
        itemBuilder: (contex, index){
          return GestureDetector(
            child: topMoviePoster(genres[index]),
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => TopMovieFilter(
                    title: genres[index],
                    bloc: bloc,
                    event: FetchTopMoviesByGenres([genres[index]]),
                  )
                )
              );
            },
          );
        },
        itemCount: genres.length,
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
      ),
      height: MediaQuery.of(context).size.height - 234,
    );
  }

  Widget topMoviePoster(String title){
    return Container(
      child: Column(
        children: <Widget>[   
          Stack(
            children: <Widget>[
              ClipRRect(
                child: FadeInImage(
                  placeholder: AssetImage('assets/defaultcover.png'), 
                  image: NetworkImage('http://image.tmdb.org/t/p/w185//amY0NH1ksd9xJ9boXAMmods6U0D.jpg'),
                  height: heigthMovie,
                  width: widthMovie,
                  fit: BoxFit.cover,
                ),
                borderRadius: borderRadius,
              ),
              Container(
                width: widthMovie,
                height: heigthMovie,
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
                bottom: 0,
                child: Container(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  width: widthMovie,
                ),
              ),
            ],
            fit: StackFit.passthrough,
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 10,right: 10),
    );
  }
}