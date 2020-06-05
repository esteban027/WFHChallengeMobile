import '../models/page_model.dart';

abstract class MoviesEvent {}

class FetchAllMovies extends MoviesEvent {
 int page ;
FetchAllMovies([this.page = 1]);
}

class FetchTopMovies extends MoviesEvent {
 int page ;
FetchTopMovies([this.page = 1]);
}

class FetchMoviesByGenres extends MoviesEvent {
 int page ;
 List<String> genres;

 FetchMoviesByGenres(this.genres, [this.page = 1]);
}

class FetchTopMoviesByGenres extends MoviesEvent {
 int page ;
 List<String> genres;

 FetchTopMoviesByGenres(this.genres, [this.page = 1]);
}

class FetchMoviesByTitle extends MoviesEvent {
 int page ;
 String title ;

 FetchMoviesByTitle(this.title, [this.page = 1]);
}

