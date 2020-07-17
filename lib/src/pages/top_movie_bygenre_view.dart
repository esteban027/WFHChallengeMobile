import 'package:WFHchallenge/src/Events/sections_events.dart';
import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/States/sections_states.dart';
import 'package:WFHchallenge/src/blocs/sections_bloc.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/models/sections_page_model.dart';
import 'package:WFHchallenge/src/pages/top_movie_filter_view.dart';
import 'package:WFHchallenge/src/resources/network.dart';
import 'package:WFHchallenge/src/resources/sign_in_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopMovie extends StatefulWidget {
  final LoadMoviesBloc bloc;
  TopMovie({Key key, @required this.bloc}) : super(key: key);

  @override
  _TopMovieState createState() => _TopMovieState(bloc);
}

class _TopMovieState extends State<TopMovie> {
  final LoadMoviesBloc bloc;
  final network = Network();
  final double widthMovie = 187;
  final double heigthMovie = 128;
  final Color _blue = Color.fromRGBO(28, 31, 44, 1);
  final BorderRadius borderRadius = BorderRadius.circular(6.0);

  _TopMovieState(this.bloc);

  final LoadSectionsBloc genreBloc = LoadSectionsBloc();

  @override
  Widget build(BuildContext context) {
    genreBloc.add(FetchAllGenresSections());

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: _blue,
        leading: Container(
          child: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white, size: 28),
          ),
          width: 40,
        ),
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                'Top Movies by Genre',
                style: TextStyle(fontSize: 23, color: Colors.white),
              ),
              margin: EdgeInsets.only(top: 5, bottom: 10),
            ),
            BlocBuilder(
                bloc: genreBloc,
                builder: (BuildContext context, state) {
                  if (state is SectionLoaded) {
                    return topGenreCollection(
                        state.sectionsPage.items, context);
                  }
                  return Center(child: CircularProgressIndicator());
                })
          ],
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/gradient.png'), fit: BoxFit.cover)),
      ),
    );
  }

  Widget topGenreCollection(List<SectionModel> genres, BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: (157 / 108)),
        itemBuilder: (contex, index) {
          return GestureDetector(
            child: topMoviePoster(genres[index].id, genres[index].posterPath),
            onTap: () async {
              final signInRepository =
                  Provider.of<SignInRepository>(context, listen: false);

              var user = await signInRepository.getUserInfo();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TopMovieFilter(
                            title: genres[index].id,
                            event: FetchTopMoviesByGenres([genres[index].id]),
                            genreEvent: genres[index].id,
                            userId: user.id,
                          )));
            },
          );
        },
        itemCount: genres.length,
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
      ),
      height: MediaQuery.of(context).size.height * 0.73,
    );
  }

  Widget topMoviePoster(String title, String posterPath) {
    return Container(
      child: Stack(
        children: <Widget>[
          ClipRRect(
            child: FadeInImage(
              placeholder: AssetImage('assets/defaultcover.png'),
              image: NetworkImage(posterPath),
              height: heigthMovie,
              width: widthMovie,
              fit: BoxFit.cover,
            ),
            borderRadius: borderRadius,
          ),
          Container(
            width: widthMovie,
            height: heigthMovie,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.transparent, _blue],
              stops: [0.0, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
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
                    fontWeight: FontWeight.bold),
              ),
              width: widthMovie,
            ),
          ),
        ],
        fit: StackFit.passthrough,
      ),
    );
  }
}
