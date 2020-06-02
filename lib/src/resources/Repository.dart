import 'dart:async';
import 'network.dart';
import '../models/page_model.dart';

class Repository {
  
  final moviesApiProvider = Network();

  Future<PageModel> fetchAllMovies() => moviesApiProvider.fetchMovies();
}