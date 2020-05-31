
import 'package:WFHchallenge/src/search/search_delegate.dart';
import 'package:flutter/material.dart';
import 'filter_genres_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  Color _orange = Color.fromRGBO(235, 89, 25, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
           actions: <Widget>[
             IconButton(
               icon: Icon(Icons.assessment),
                onPressed: (){
                  showSearch(
                    context: context,
                    delegate: DataSearch()
                  );
                }
            )
           ],
           backgroundColor: _blue,
         ),
         body: Container(
           child: Center(
             child: FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute (builder: (context) => FilterGenresView()));
              },
              child: Icon(Icons.movie_creation)
          ),
           ),
          
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/gradient.png'),
              fit: BoxFit.cover
            ),
          ),
        )
       )
    );
  }
}

          // leading:  FlatButton(
          //   child: Icon(Icons.assessment),
          //   onPressed: (){
          //     Navigator.push(context, MaterialPageRoute (builder: (context) => FilterGenresView()));
          //   },
          //   ),