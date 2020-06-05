abstract class MoviesEvent {
  void setPage(int page);
}

class BasicMovieEvent  extends MoviesEvent{
int page ;
BasicMovieEvent(this.page);
 @override 
  void setPage(int page ) {
    this.page = page;
  }
}


class ReturnToInitialState extends BasicMovieEvent {
  ReturnToInitialState() : super(1);
}

class FetchAllMovies extends BasicMovieEvent {
FetchAllMovies([int page = 1]) : super(page);
}

class FetchTopMovies extends BasicMovieEvent {
FetchTopMovies([int page = 1]): super(page);
}

class FetchMoviesByGenres extends BasicMovieEvent {
 List<String> genres;

 FetchMoviesByGenres(this.genres, [int page = 1]): super(page);
}

class FetchTopMoviesByGenres extends BasicMovieEvent {
 List<String> genres;

 FetchTopMoviesByGenres(this.genres, [int page = 1]): super(page);
}

class FetchMoviesByTitle extends BasicMovieEvent {
 String title ;

 FetchMoviesByTitle(this.title, [int page = 1]): super(page);
}

class FetchTopMoviesByLatestRelease extends BasicMovieEvent {
 FetchTopMoviesByLatestRelease([int page = 1]): super(page);
}

