import 'package:flutter/foundation.dart';
import '../models/page_model.dart';

@immutable
abstract class MoviesState {}

class MoviesLoading extends MoviesState {
  @override
  String toString() => 'MoviesLoading';
}

class MoviesLoaded extends MoviesState {
  final PageModel movies;

  MoviesLoaded(this.movies);

  @override
  String toString() => 'MoviesLoaded{movies: $movies}';
}

class MoviesNotLoaded extends MoviesState {
  @override
  String toString() => 'TodosNotLoaded';
}
