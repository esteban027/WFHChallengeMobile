import 'package:flutter/foundation.dart';
import '../models/page_model.dart';

@immutable
abstract class MoviesState {}

class MoviesLoading extends MoviesState {
  @override
  String toString() => 'MoviesLoading';
}

class MoviesLoaded extends MoviesState {
  final MoviesPageModel moviesPage;

  MoviesLoaded(this.moviesPage);

  @override
  String toString() => 'MoviesLoaded{movies: $moviesPage}';
}

class MoviesNotLoaded extends MoviesState {
  @override
  String toString() => 'MoviesNotLoaded';
}

class MoviesPaginationLoading extends MoviesState {
  @override
  String toString() => 'MoviesPaginationLoading';
} 
