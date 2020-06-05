import 'package:flutter/foundation.dart';
import '../models/genres_page_model.dart';

@immutable
abstract class GenresState {}

class GenresLoading extends GenresState {
  @override
  String toString() => 'GenresLoading';
}

class GenresLoaded extends GenresState {
  final GenresPageModel genresPage;

  GenresLoaded(this.genresPage);

  @override
  String toString() => 'GenresLoaded{genres: $genresPage}';
}

class GenresNotLoaded extends GenresState {
  @override
  String toString() => 'GenresNotLoaded';
}
