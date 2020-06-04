import 'package:WFHchallenge/src/models/Movie.dart';
import 'package:WFHchallenge/src/pages/top_movie_filter_view.dart';
import 'package:WFHchallenge/src/providers/provider.dart';
import 'package:flutter/material.dart';

class TopMovie extends StatefulWidget {
  TopMovie({Key key}) : super(key: key);

  @override
  _TopMovieState createState() => _TopMovieState();
}

class _TopMovieState extends State<TopMovie> {
  final provider = new Provider();
  final double widthMovie = 187;
  final double heigthMovie = 128;
  final Color _blue = Color.fromRGBO(28, 31, 44, 1);
  final BorderRadius borderRadius = BorderRadius.circular(6.0);
  final genres = ['Animation', 'Action', 'Adventure', 'Biography', 'Comedy', 'Crime', 'Drama', 'Documentary', 'Fantasy', 'Historical', 'Horror'];

  @override
  Widget build(BuildContext context) {
    provider.getMovies();
    return Scaffold(
      appBar: AppBar(backgroundColor:_blue,),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text('Top Movies by Gender', style: TextStyle(fontSize: 23, color: Colors.white),),
              margin: EdgeInsets.only(top: 15),
            ),
            StreamBuilder(
              stream: provider.moviesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return topMovieCollection(snapshot.data, context);
                } else {
                  print('error ');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
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

  Widget topMovieCollection(List<Movie> movies, BuildContext context) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => TopMovieFilter(title: genres[index],)));
            },
          );
        },
        itemCount: genres.length,
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
      ),
      height: MediaQuery.of(context).size.height - 200,
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