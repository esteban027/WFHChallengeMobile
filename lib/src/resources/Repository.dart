import 'dart:async';
import 'network.dart';
import '../models/item_model.dart';

class Repository {
  final moviesApiProvider = Network();

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovies();
}