
import 'package:WFHchallenge/src/search/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../icons2_icons.dart';
import 'filter_genres_page.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  Color _orange = Color.fromRGBO(235, 89, 25, 1);

  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ]
      ),
      body: Container(
        padding: EdgeInsets.only(top:70, left: 40, right: 40),
        child: SearchBar(
          onSearch: search,
          onItemFound: (Post post, int index) {
            return ListTile(
              title: Text(post.title, style: TextStyle(color: Colors.white),),
              subtitle: Text(post.description, style: TextStyle(color: Colors.white)),
            );
          },
          
          iconActiveColor: Colors.white,
          textStyle: TextStyle(color: Colors.white,),
        ),
        color: _blue,
      ),
    );
  }
}

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}