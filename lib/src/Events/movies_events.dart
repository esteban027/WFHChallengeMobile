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


