import '../models/item_model.dart';

abstract class MoviesEvent {}

class LoadAllMovies extends MoviesEvent {
  @override
  String toString() => 'LoadMovies';
}