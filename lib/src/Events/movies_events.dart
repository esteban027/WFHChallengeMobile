import 'package:flutter/cupertino.dart';
import '../Events/pages_events.dart';

class FetchAllMovies extends BasicPageEvent {
  FetchAllMovies([int page = 1]) : super(page);
}

class FetchTopMovies extends BasicPageEvent {

  FetchTopMovies([int page = 1]) : super(page);
}

class FetchMoviesByGenres extends BasicPageEvent {
  List<String> genres;

  FetchMoviesByGenres(this.genres, [int page = 1]) : super(page);
}

class FetchTopMoviesByGenres extends BasicPageEvent {
  List<String> genres;

  FetchTopMoviesByGenres(this.genres, [int page = 1]) : super(page);
}

class FetchMoviesByTitle extends BasicPageEvent {
  String title;

  FetchMoviesByTitle(this.title, [int page = 1]) : super(page);
}

class FetchTopMoviesByLatestRelease extends BasicPageEvent {
  FetchTopMoviesByLatestRelease([int page = 1]) : super(page);
}

class FetchMoviesRecommendationToUser extends BasicPageEvent{
  int userId;
  FetchMoviesRecommendationToUser(this.userId, [int page = 1]) : super(page);
}

class PaginateMovies extends BasicPageEvent {
  PaginateMovies() : super(1);
}