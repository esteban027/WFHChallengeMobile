

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:WFHchallenge/src/models/Movie.dart';

class Provider {
  String _url = 'wfh-movies.herokuapp.com';
  String _endPoint = 'movie';
  int _moviesPerPage = 15;
  int _page = 0;
  bool _loading = false;

  List<Movie> _movies = new List();
  final _moviesStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get moviesSink => _moviesStreamController.sink.add;

  Stream<List<Movie>> get moviesStream => _moviesStreamController.stream;


  void disposeStreams() {
    _moviesStreamController?.close();
  }

  Future <List<Movie>> getMovies() async {
    if (_loading) return [];
    _loading = true;

    _page ++;

    final url = Uri.http(_url, _endPoint, {
      'limit' : '$_moviesPerPage',
      'page'  : '$_page',
    });

    final resp = await http.get(url,headers: {'API_KEY':'y1N478S5GfjcSlaiyUp7oaztpRNUii7lhwl7cvbNinIjPu2AWzRf7T9qH7dFuPcC'});
    final decodedData = json.decode(resp.body);
    // print(decodedData);
    final movies = Movies.fromJsonList(decodedData['items']);
    final moviesInfo = Movies.fromJsonMap(decodedData);
    final movie = movies.items[0];

    _movies.addAll(movies.items);
    moviesSink(_movies);
    _loading = false;
    return movies.items;
  }
}