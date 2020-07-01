import '../resources/movies_page_repository.dart';
import 'package:bloc/bloc.dart';
import '../Events/movies_events.dart';
import '../Events/pages_events.dart';
import '../States/movies_states.dart';

class LoadMoviesBloc extends Bloc<PageEvent, MoviesState> {
  MoviesPageRepository repository;

  @override
  MoviesState get initialState => MoviesLoading();

  @override
  Stream<MoviesState> mapEventToState(PageEvent event) async* {
    repository = MoviesPageRepository();
    if (event is FetchAllMovies) {
      yield* _mapLoadAllMovies(event.page);
    } else if (event is FetchTopMovies) {
      yield* _mapLoadTopMovies(event.page);
    } else if (event is FetchMoviesByGenres) {
      yield* _mapLoadMoviesByGenres(event.page, event.genres);
    } else if (event is FetchTopMoviesByGenres) {
      yield* _mapLoadTopMoviesByGenres(event.page, event.genres);
    } else if (event is FetchMoviesByTitle) {
      yield* _mapLoadMoviesByTitle(event.page, event.title);
    } else if (event is FetchTopMoviesByLatestRelease) {
      yield* _mapLoadTopMoviesByReleaseDate(event.page);
    } else if (event is ReturnToInitialState) {
      yield initialState;
    } else if (event is FetchMoviesRecommendationToUser) {
      yield*  _mapRecommendMoviesTo(event.userId, event.page);
    } else if (event is FetchMoviesRecommendationFromMovie) {
      yield* _mapRecommendMoviesFrom(event.movieId,event.page);
    } else if (event is PaginateMovies){
      yield  MoviesPaginationLoading();
    }
  }

  Stream<MoviesState> _mapLoadAllMovies(int page) async* {
    try {
      final movies = await this.repository.fetchAllMovies(page);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapLoadTopMovies(int page) async* {
    try {
      final movies = await this.repository.fetchTopMovies(page);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapLoadMoviesByGenres(
      int page, List<String> genres) async* {
    try {
      final movies = await this.repository.fetchMoviesByGenres(page, genres);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapLoadTopMoviesByGenres(
      int page, List<String> genres) async* {
    try {
      final movies = await this.repository.fetchTopMoviesByGenres(page, genres);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapLoadMoviesByTitle(int page, String title) async* {
    try {
      final movies = await this.repository.fetchMoviesByTitle(page, title);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapLoadTopMoviesByReleaseDate(int page) async* {
    try {
      final movies = await this.repository.fetchTopMoviesByReleaseDate(page);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapRecommendMoviesTo(int userId, int page)  async* {
    try {
      final movies = await this.repository.fetchMoviesRecommendationTo(userId, page);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }

  Stream<MoviesState> _mapRecommendMoviesFrom(int movieId, int page)  async* {
    try {
      final movies = await this.repository.fetchMoviesRecommendationFrom(movieId,page);
      yield MoviesLoaded(movies);
    } catch (_) {
      yield MoviesNotLoaded();
    }
  }
}
